
import os
import re
from flask import Flask, request, jsonify
from dotenv import load_dotenv
from groq import Groq

# 1. Force python to look directly inside its own folder context for the hidden .env file
# This prevents the infinite 'Processing' hang caused by a missing API Key context
backend_dir = os.path.dirname(os.path.abspath(__file__))
load_dotenv(dotenv_path=os.path.join(backend_dir, '.env'))

app = Flask(__name__)

# 2. Initialize your secure Groq client matching your environment file naming case layout exactly
client = Groq(api_key=os.environ.get("Groq_API_Key"))

# 3. Hardcoded Strict Safety Rules to keep the app completely legal and prevent chatbot from getting off track
SYSTEM_PROMPT = """
You are a medical terminology translator for an educational app. Your sole job is to explain complex medical concepts, terms, treatments, or anatomy in simple, universal language accessible to a teenager.
Try not to use more than 2-3 and 2-3 sentences per question unless needed. If asked to "simplify" or "explain simply" shorten it
Try not to use more that 4-5 bullets if using bullets in response

Critical SCOPE & DOMAIN RESTRICTIONS
1. You are strictly restricted to answering questions about medical terms, human biology, laboratory metrics, clinical concepts, and healthcare science, treatments, or anatomy.
2. If the user asks a non-medical question (e.g., about sports, celebrities, history, math, coding, or generic chat), you must politely decline. Respond ONLY with this exact phrase: "This educational tool is configured exclusively for medical understanding. Please ask a health-related question."
3. You are fully expected to handle conversational follow-up questions (such as requests for bullet points, elaborations, or simple summaries) that reference the provided context of the previous message. As long as the primary underlying subject matter is medical, fulfill the follow-up request completely using the third-person rule.


CRITICAL SAFETY DIRECTIVES
1. Speak completely objectively. Use third-person terms ("A person experiencing...", "Patients with...") instead of second-person ("You should...", "Your symptoms...").
2. Absolutely NEVER diagnose, prescribe medication, outline a specific timeline for healing a specific person, or offer an emergency action plan.
3. If the input text contains explicit cries for personal help, severe immediate emergency symptoms, or requests for a diagnosis, reject the input entirely. Respond ONLY with this exact phrase: "ERROR: This tool is for educational definitions only. Please consult a licensed healthcare professional for clinical advice or emergency care."
"""

@app.route('/explain', methods=['POST'])
def explain():
    user_data = request.json
    user_query = user_data.get("query", "")
    prev_ai_context = user_data.get("previous_ai_response", "")
  
    
    # 4. Clean up generic or personal family member phrases using RegEx boundaries
    clean_query = user_query.lower()
    family_pattern = r"\b(my\s+)?(mom|dad|son|daughter|aunt|uncle|grandpa|grandma|cousin|niece|nephew|sister|brother|child|kids|parent|mother|father|wife|husband|friend)\b" 
    clean_query = re.sub(r"\bi\s+have\b", "what is", clean_query)
    clean_query = re.sub(family_pattern + r"\s+has\b", "what is", clean_query)
    clean_query = re.sub(family_pattern + r"'s\b", "", clean_query)
     
    
    if prev_ai_context:
        final_user_prompt = f"Context from previous message: \"{prev_ai_context}\"\n\nFollow-up request: {clean_query}"
    else:
        final_user_prompt = clean_query

    # 3. Assemble the payload cleanly
    messages_payload = [
        {"role": "system", "content": SYSTEM_PROMPT},
        {"role": "user", "content": final_user_prompt}
    ]

    try:
      
        # An active, free-tier model string target on the Groq infrastructure
        chat_completion = client.chat.completions.create(
            messages=messages_payload,
            model="llama-3.3-70b-versatile", # Active, blazing fast, and free!
            temperature=0.3, 
        )
      
        
        #Safely target index of choices to grab the text reply payload cleanly
        reply = chat_completion.choices[0].message.content
       
        return jsonify({"explanation": reply}), 200

    except Exception as e:
      
        return jsonify({"explanation": f"Server processing error: {str(e)}"}), 500

if __name__ == '__main__':
    # Runs the server locally on port 8000
    app.run(host='127.0.0.1', port=8000, debug=True)



