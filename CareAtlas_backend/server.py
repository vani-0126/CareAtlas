import os
import re
from flask import Flask, request, jsonify
from dotenv import load_dotenv
from groq import Groq

# 1. Force python to look directly inside its own folder context for the hidden .env file
backend_dir = os.path.dirname(os.path.abspath(__file__))
load_dotenv(dotenv_path=os.path.join(backend_dir, '.env'))

app = Flask(__name__)

# 2. Initialize your secure Groq client matching your environment file naming case layout exactly
client = Groq(api_key=os.environ.get("Groq_API_Key") or os.environ.get("GROQ_API_KEY"))

# 3. Hardcoded Strict Safety Rules to keep the app completely legal
Medical_Explainer_PROMPT = """
You are a medical terminology translator for an educational app. Your sole job is to explain complex medical concepts, terms, treatments, or anatomy in simple, universal language accessible to a teenager. Try not to use more than 2-3 sentences per question unless needed. If asked to "simplify" or "explain simply" shorten it. Try not to use more than 4-5 bullets if using bullets in response.

Critical SCOPE & DOMAIN RESTRICTIONS
1. You are strictly restricted to answering questions about medical terms, human biology, laboratory metrics, clinical concepts, and healthcare science, treatments, or anatomy.
2. If the user asks a non-medical question (e.g., about sports, celebrities, history, math, coding, or generic chat), you must politely decline. Respond ONLY with this exact phrase: "This educational tool is configured exclusively for medical understanding. Please ask a health-related question."
3. You are fully expected to handle conversational follow-up questions that reference the provided context of the previous message. As long as the primary underlying subject matter is medical, fulfill the follow-up request completely using the third-person rule.

CRITICAL SAFETY DIRECTIVES
1. Speak completely objectively. Use third-person terms ("A person experiencing...", "Patients with...") instead of second-person ("You should...", "Your symptoms...").
2. Absolutely NEVER diagnose, prescribe medication, outline a specific timeline for healing a specific person, or offer an emergency action plan.
3. If the input text contains explicit cries for personal help, severe immediate emergency symptoms, or requests for a diagnosis, reject the input entirely. Respond ONLY with this exact phrase: "ERROR: This tool is for educational definitions only. Please consult a licensed healthcare professional for clinical advice or emergency care."
"""

QUESTION_BUILDER_PROMPT = """
You are a patient appointment preparation assistant. Based on the user's upcoming appointment or concerns, generate 5-8 thoughtful questions they could ask their healthcare provider.

SCOPE & DOMAIN RESTRICTIONS
1. Do NOT answer the questions.
2. Do NOT explain medical concepts.
3. Return ONLY a numbered list.
4. If user types anything non-medical related (e.g., about sports, celebrities, history, math, coding, or generic chat), you must politely decline. Respond ONLY with this exact phrase: "ERROR: This tool is configured exclusively for medical understanding. Please type concerns and details about an upcoming appointment."
"""

@app.route("/explain", methods=["POST"])
def explain():
    user_data = request.json or {}
    user_query = user_data.get("query", "")
    prev_ai_context = user_data.get("previous_ai_response", "")
    
    clean_query = user_query.lower()
    family_pattern = r"\b(my\s+)?(mom|dad|son|daughter|aunt|uncle|grandpa|grandma|cousin|niece|nephew|sister|brother|child|kids|parent|mother|father|wife|husband|friend)\b"
    clean_query = re.sub(r"\bi\s+have\b", "what is", clean_query)
    clean_query = re.sub(family_pattern + r"\s+has\b", "what is", clean_query)
    clean_query = re.sub(family_pattern + r"'s\b", "", clean_query)
    
    if prev_ai_context:
        final_user_prompt = f"Context from previous message: \"{prev_ai_context}\"\n\nFollow-up request: {clean_query}"
    else:
        final_user_prompt = clean_query
        
    messages_payload = [
        {"role": "system", "content": Medical_Explainer_PROMPT},
        {"role": "user", "content": final_user_prompt}
    ]
    try:
        chat_completion = client.chat.completions.create(
            messages=messages_payload,
            model="qwen/qwen3.8-27b",
            temperature=0.3,
        )
        reply = chat_completion.choices[0].message.content
        reply = re.sub(r"<think>.*?</think>", "", reply, flags=re.DOTALL).strip()
        return jsonify({"explanation": reply}), 200
    except Exception as e:
        print(f"Explain Error Trace: {str(e)}")
        return jsonify({"explanation": f"Server processing error: {str(e)}"}), 500

@app.route("/questions", methods=["POST"])
def questions():
    user_data = request.json or {}
    
    # FIXED: Extract data whether it comes via basic 'query' or Dart's complex properties layout
    user_query = user_data.get("query")
    if not user_query:
        appt_type = user_data.get("appointment_type", "")
        desc = user_data.get("description", "")
        user_query = f"Appointment Type: {appt_type}. Description Context: {desc}".strip()
        
    prev_ai_context = user_data.get("previous_ai_response", "")
    
    clean_query = user_query.lower()
    family_pattern = r"\b(my\s+)?(mom|dad|son|daughter|aunt|uncle|grandpa|grandma|cousin|niece|nephew|sister|brother|child|kids|parent|mother|father|wife|husband|friend)\b"
    clean_query = re.sub(r"\bi\s+have\b", "what is", clean_query)
    clean_query = re.sub(family_pattern + r"\s+has\b", "what is", clean_query)
    clean_query = re.sub(family_pattern + r"'s\b", "", clean_query)
    
    if prev_ai_context:
        final_user_prompt = f"Context from previous message: \"{prev_ai_context}\"\n\nFollow-up request: {clean_query}"
    else:
        final_user_prompt = clean_query
        
    messages_payload = [
        {"role": "system", "content": QUESTION_BUILDER_PROMPT},
        {"role": "user", "content": final_user_prompt}
    ]
    try:
        chat_completion = client.chat.completions.create(
            messages=messages_payload,
            model="qwen/qwen3.8-27b",
            temperature=0.3,
        )
        reply = chat_completion.choices[0].message.content
        reply = re.sub(r"<think>.*?</think>", "", reply, flags=re.DOTALL).strip()
        return jsonify({"questions": reply}), 200
    
    except Exception as e:
        print(f"Questions Error Trace: {str(e)}")
        return jsonify({"questions": f"Server processing error: {str(e)}"}), 500


if __name__ == '__main__':
    app.run(host='127.0.0.1', port=8080, debug=True)



