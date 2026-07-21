class MedicalTerm {
  final String term;
  final String definition;
  final String secondSectionTitle;
  final List<String> secondSectionItems;

  MedicalTerm({
    required this.term,
    required this.definition,
    required this.secondSectionTitle,
    required this.secondSectionItems,
  });
}

final medicalTerms = [
  MedicalTerm(
    term: "Abrasion",
    definition: "A scraping or rubbing away of the skin or other surface.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "redness",
      "mild bleeding",
      "tearing",
      "stinging or burning sensations",
    ],
  ),
  MedicalTerm(
    term: "Acne",
    definition:
        "An inflammatory disease resulting from excess sebum production, follicle plugging, and increased bacterial production.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "blackheads (plugged pores on the skin's surface)",
      "whiteheads (plugged pores beneath the skin's surface)",
      "red or discolored bumps",
      "pastules (pimples)",
      "nodules (painful lumps)",
    ],
  ),
  MedicalTerm(
    term: "Alopecia",
    definition: "Suddern hair loss or baldness.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "thinning of hair",
      "patchy hair loss",
      "pitting, ridges, or roughness on nails",
      "body hair loss",
      "excessive shedding or hair loss",
    ],
  ),
  MedicalTerm(
    term: "Alzeimer's Disease",
    definition:
        "A progressive, irreversible brain disorder that slowly destroys memory and thinking skills.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "short term memory loss",
      "trouble planning or problem solving",
      "language difficulties",
      "getting lost or confused with familar places and things",
    ],
  ),
  MedicalTerm(
    term: "Anemia",
    definition:
        "A lack of enough healthy red blood cells to carry adequate oxygen.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "extreme fatigue",
      "weakness",
      "shortness of breath",
      "dizzines",
      "paler skin",
    ],
  ),
  MedicalTerm(
    term: "Angina",
    definition:
        "Severe chest pain caused by inadequate blood flow to the heart.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "feeling pressure, squeezing, or tightness in the chest",
      "frequent pain",
      "radiating pain (spreading pain)",
      "shotness of breath and dizziness",
      "nausea and vomiting",
    ],
  ),
  MedicalTerm(
    term: "Anorexia",
    definition:
        "An eating disorder characterized by an intense fear of gaining weight and abnormally low body weight.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "low body weight",
      "extreme fear of becoming fat",
      "excessive physical activity",
      "denial of hunger",
      "fixation with making food",
      "obsessive or ritualized eating behaviors.",
      "Note: Sometimes called Anorexia Nervosa (AN)",
    ],
  ),
  MedicalTerm(
    term: "Appendicitis",
    definition:
        "The inflammation of the appendix, a small pouch attached to the large intestine.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "fever"
          "mild, dull ache near the belly",
      "sharper, progressing pain in the belly",
      "bloating, constipation, or gas",
      "pain that migrates to the right abdomen",
    ],
  ),
  MedicalTerm(
    term: "Apnea",
    definition:
        "The temporary cessation of breathing, especially during sleep.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "excessive sleepiness (awake)",
      "morning headaches (awake)",
      "loud snoring (asleep)",
      "gasping or choking (asleep)",
      "breathing interruptions (asleep)",
    ],
  ),
  MedicalTerm(
    term: "Arrhythmia",
    definition:
        "An irregular, too fast, or too slow heartbeat caused by faulty electrical signals in the heart.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "pounding chest sensations",
      "chest discomfort"
          "dizziness",
      "fatigue",
      "shortness of breath",
    ],
  ),
  MedicalTerm(
    term: "Arthritis",
    definition:
        "A general term for conditions that cause inflammation, pain, and swelling in the joints and surrounding connective tissues.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "joint pain, tenderness, or aching",
      "stiffness",
      "swelling in or around the joint",
      "redness and warmth of the skin over the joint",
      "decreased range of motion or flexibility",
      "Note: there are many types of arthritis",
    ],
  ),
  MedicalTerm(
    term: "Asthma",
    definition:
        "A chronic inflammation of the airways making breathing difficult.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "wheezing",
      "shortness of breath",
      "chest tightness",
      "frequent coughing",
      "trouble sleeping",
    ],
  ),
  MedicalTerm(
    term: "Atherosclerosis",
    definition:
        "A condition where fatty deposits called plaque, build up inside your arteries.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "chest pains",
      "shortness of breath",
      "sudden numbness or weakness in the limbs",
      "Note: symptoms aren't visible in its early stages",
    ],
  ),
  MedicalTerm(
    term: "Autoimmune",
    definition:
        "A condition where the immune system mistakenly attacks healthy cells.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "persisten fatigue",
      "joint and muscle pain",
      "rashes, sores, or red, scaly patches",
      "low-grade fever",
      "bloating, cramping, diarrhea, or constipation",
      "unexplained weight loss or weight gain",
      "Note: there are many types of autoimmune diseases",
    ],
  ),
  MedicalTerm(
    term: "Bronchitis",
    definition:
        "The inflammation of the airways in your lungs, usually triggered by a viral infection.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "persistent cough",
      "mucus production",
      "shortness of breath",
      "wheezing",
      "fatigue",
    ],
  ),
  MedicalTerm(
    term: "Bulimia",
    definition:
        "An eating disorder characterized by episodes of secret binge eating followed by purging.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "normal or above average body weight",
      "self-induced vomiting (often in secret)",
      "excessive exercise and fasting",
      "misuse of laxatives or diuretics",
      "Note: Sometimes called Bulimia Nervosa (BN)",
    ],
  ),
  MedicalTerm(
    term: "Cancer",
    definition:
        "A disease characterized by the uncontrolled growth and spread of abnormal cells.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "unexplained weight changes",
      "persistent fatigue and lack of energy",
      "fervers and night sweats",
      "abnormal bleeding",
      "unusual lumps and skin changes",
      "Note: there are many types of cancer and symptoms can vary based on the type",
    ],
  ),
  MedicalTerm(
    term: "Cataract",
    definition: "Clouding of the eye's normally clear lens.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "blurred or dim vision",
      "increased glare",
      "need for brighter light",
      "fading or yellowing of colors",
    ],
  ),
  MedicalTerm(
    term: "Cellulitus",
    definition:
        "A common, potentially serious bacterial skin infection that causes redness, swelling, and pain in the infected skin and underlying tissues.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "spreading of redness, tenderness, and swelling",
      "fevers, chills, and fatigue",
    ],
  ),
  MedicalTerm(
    term: "Chronic Obstructive Pulmonary Disease (COPD)",
    definition:
        "A group of lung diseases that block airflow and make it difficult to breathe.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "persistent coughs",
      "significant mucus production",
      "wheezing",
      "chest tightness",
      "shortness of breath",
    ],
  ),
  MedicalTerm(
    term: "Cirrhosis",
    definition:
        "Advanced liver scarring where healthy tissue is replaced by scar tissue, blocking blood flow and preventing the liver from processing nutrients, hormones, and toxins.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "yellowing skin",
      "a swollen belly",
      "swelling in the legs",
      "easy bruising",
      "fatigue and mental confusion",
    ],
  ),
  MedicalTerm(
    term: "Conjunctivitis",
    definition:
        "An inflammation of the conjunctiva, the thin, clear tissue that lies over the white part of the eye and lines the inside of the eyelid.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "redness in one or both eyes",
      "itchiness in one or both eyes",
      "a gritty feeling in one or both eyes",
      "discharge that forms a crust during the night",
      "tearing",
    ],
  ),
  MedicalTerm(
    term: "Dermatitis:",
    definition: "Inflammation of the skin.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "redness and itching",
      "rash",
      "dry, scaly skin",
      "blisters",
    ],
  ),
  MedicalTerm(
    term: "Diabetes",
    definition:
        "A chronic metabolic disease where the body cannot produce enough insulin or use it effectively, resulting in high blood sugar levels.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "increased thirst and urination",
      "extreme hunger",
      "unexplained weight loss",
      "fatigue",
      "blurred vision",
      "Note: there are different types of diabetes, including Type 1, Type 2, and gestational diabetes",
    ],
  ),
  MedicalTerm(
    term: "Diarrhea",
    definition:
        "A condition characterized by frequent, loose, or watery bowel movements.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "frequent loose or watery stools",
      "abdominal cramps and pain",
      "nausea and vomiting",
      "fever",
      "dehydration",
    ],
  ),
  MedicalTerm(
    term: "Dyspnea",
    definition: "Shortness of breath or difficulty breathing.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "feeling of breathlessness",
      "difficulty breathing deeply",
      "rapid breathing",
    ],
  ),
  MedicalTerm(
    term: "Eczema",
    definition:
        "a chronic inflammatory skin condition that causes dry, red, and intensely itchy patches of skin.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "itching",
      "red, inflamed skin",
      "dry, scaly skin",
      "small, raised bumps",
    ],
  ),
  MedicalTerm(
    term: "Edema",
    definition: "The accumulation of fluid in body tissues, causing swelling.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "swelling in the affected area",
      "weight gain",
      "skin that looks stretched or shiny",
      "pitting (indentation that remains when pressure is applied)",
    ],
  ),
  MedicalTerm(
    term: "Electrolyte Imbalance",
    definition:
        "A condition where the levels of electrolytes in the body are either too high or too low, affecting various bodily functions.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "irregular heartbeat",
      "muscle weakness or twitching",
      "confusion or irritability",
      "nausea and vomiting",
      "fatigue",
    ],
  ),
  MedicalTerm(
    term: "Embolism",
    definition:
        "A sudden, dangerous blockage in a blood vessel by an undissolved mass.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "sudden onset of severe chest pain",
      "difficulty breathing",
      "rapid heart rate",
      "dizziness or fainting",
    ],
  ),
  MedicalTerm(
    term: "Emphysema",
    definition:
        "A chronic lung condition that causes shortness of breath due to damage to the air sacs (alveoli) in the lungs.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "shortness of breath, especially during physical activity",
      "chronic cough",
      "wheezing",
      "fatigue",
      "weight loss",
    ],
  ),
  MedicalTerm(
    term: "Endometriosis",
    definition:
        "A painful disorder where tissue similar to the lining of the uterus grows outside the uterus.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "painful periods",
      "pain during intercourse",
      "pain with bowel movements or urination",
      "excessive bleeding",
      "infertility",
    ],
  ),
  MedicalTerm(
    term: "Epilepsy",
    definition:
        "A neurological disorder marked by sudden, recurrent episodes of sensory disturbance or seizures.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "temporary confusion",
      "staring spells",
      "uncontrollable jerking movements of the arms and legs",
      "loss of consciousness or awareness",
      "psychic symptoms (such as fear, anxiety, or déjà vu)",
    ],
  ),
  MedicalTerm(
    term: "Erectile Dysfunction",
    definition:
        "The inability to get or keep an erection firm enough for sexual intercourse.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "difficulty getting an erection",
      "trouble maintaining an erection during sexual activities",
      "reduced sexual desire",
    ],
  ),
  MedicalTerm(
    term: "Esophagitis",
    definition:
        "Inflammation that damages the tube running from the throat to the stomach (esophagus).",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "painful swallowing",
      "chest pain, particularly behind the breastbone",
      "food getting stuck in the esophagus",
      "heartburn",
      "acid regurgitation",
    ],
  ),
  MedicalTerm(
    term: "Fibromyalgia",
    definition:
        "A long-term condition that makes your brain and nervous system overreact to pain signals, causing widespread aches, extreme tiredness, and memory issues.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "widespread pain",
      "fatigue",
      "cognitive difficulties (often referred to as 'fibro fog')",
      "sleep disturbances",
      "headaches",
    ],
  ),
  MedicalTerm(
    term: "Fracture",
    definition: "Any partial or complete break in a bone",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "pain at the site of the break",
      "swelling and bruising",
      "deformity or unnatural positioning of the limb",
      "inability to move the affected area",
    ],
  ),
  MedicalTerm(
    term: "Gastroenteritis",
    definition:
        "the inflammation of the stomach and intestines, commonly known as the stomach flu.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "watery diarrhea",
      "abdominal cramps and pain",
      "nausea and vomiting",
      "fever",
      "headache",
      "muscle aches",
    ],
  ),
  MedicalTerm(
    term: "Gastritis",
    definition: "Inflammation of the stomach lining.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "stomach pain",
      "nausea",
      "vomiting",
      "loss of appetite",
    ],
  ),
  MedicalTerm(
    term: "Gastroesophageal Reflux Disease (GERD)",
    definition:
        "A chronic digestive condition where stomach acid or bile flows back into the esophagus, irritating its lining.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "heartburn",
      "regurgitation of food or sour liquid",
      "difficulty swallowing",
      "chest pain",
      "chronic cough or throat irritation",
    ],
  ),
  MedicalTerm(
    term: "Glaucoma",
    definition:
        "A group of eye diseases that damage the optic nerve, often due to a buildup of fluid that increases pressure inside the eye.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "gradual loss of peripheral vision",
      "tunnel vision in advanced stages",
      "eye pain",
      "nausea and vomiting (in acute cases)",
      "blurred vision",
    ],
  ),
  MedicalTerm(
    term: "Hematoma",
    definition:
        "A collection of blood outside of a blood vessel, typically caused by trauma or injury.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: ["swelling", "bruising", "pain", "limited mobility"],
  ),
  MedicalTerm(
    term: "Hepatitis",
    definition:
        "An inflammation of the liver, often caused by viral infections, alcohol use, or autoimmune diseases.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "jaundice (yellowing of the skin and eyes)",
      "fatigue",
      "abdominal pain",
      "loss of appetite",
      "nausea and vomiting",
    ],
  ),
  MedicalTerm(
    term: "Hernia",
    definition:
        "A condition where an organ pushes through an opening in the muscle or tissue that holds it in place.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "a noticeable bulge or lump",
      "pain or discomfort, especially when bending over, coughing, or lifting",
      "weakness or pressure in the affected area",
      "burning or aching sensation at the site of the bulge",
    ],
  ),
  MedicalTerm(
    term: "Hypoglycemia",
    definition:
        "A condition characterized by abnormally low levels of blood sugar (glucose), which is the body's main energy source.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "shakiness",
      "sweating",
      "confusion",
      "irritability",
      "rapid heartbeat",
    ],
  ),
  MedicalTerm(
    term: "Hypotension",
    definition: "A condition characterized by abnormally low blood pressure.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "dizziness",
      "fainting",
      "fatigue",
      "blurred vision",
      "nausea",
    ],
  ),
  MedicalTerm(
    term: "Hypertension",
    definition:
        "A condition in which the force of the blood against the artery walls is too high, often referred to as high blood pressure.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "often asymptomatic (no symptoms)",
      "headaches",
      "shortness of breath",
      "nosebleeds",
      "chest pain",
    ],
  ),
  MedicalTerm(
    term: "Influenza",
    definition:
        "A contagious respiratory illness caused by influenza viruses that infect the nose, throat, and sometimes the lungs.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "fever or feeling feverish/chills",
      "cough",
      "sore throat",
      "runny or stuffy nose",
      "muscle or body aches",
      "headaches",
      "fatigue (tiredness)",
      "vomiting and diarrhea (more common in children than adults)",
    ],
  ),
  MedicalTerm(
    term: "Insomnia",
    definition:
        "A sleep disorder characterized by difficulty falling asleep, staying asleep, or waking up too early.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "difficulty falling asleep",
      "waking up frequently during the night",
      "waking up too early and not being able to go back to sleep",
      "daytime fatigue or sleepiness",
      "irritability, depression, or anxiety",
    ],
  ),
  MedicalTerm(
    term: "Ischemia",
    definition:
        "A condition in which blood flow to a part of the body is restricted or blocked.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "chest pain or discomfort",
      "shortness of breath",
      "nausea",
      "sweating",
      "dizziness",
    ],
  ),
  MedicalTerm(
    term: "Jaundice",
    definition:
        "A condition characterized by yellowing of the skin and eyes due to high levels of bilirubin in the blood.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "yellowing of the skin and eyes",
      "dark urine",
      "pale stools",
      "itching",
      "fatigue",
    ],
  ),
  MedicalTerm(
    term: "kidney Stones",
    definition: "A hard mass formed in the kidneys from minerals in the urine.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "severe pain in the side and back, below the ribs",
      "pain that radiates to the lower abdomen and groin",
      "painful urination",
      "pink, red, or brown urine",
      "nausea and vomiting",
      "persistent urge to urinate",
      "fever and chills if an infection is present",
    ],
  ),
  MedicalTerm(
    term: "Kyphosis",
    definition:
        "A forward rounding of the back, often resulting in a hunchback or slouching posture.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "visible rounding of the upper back",
      "back pain and stiffness",
      "fatigue",
      "difficulty standing up straight",
      "in severe cases, breathing difficulties",
    ],
  ),
  MedicalTerm(
    term: "Laceration",
    definition:
        "A deep cut or tear in the skin or flesh, often caused by sharp objects or trauma.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "bleeding",
      "pain at the site of the cut",
      "swelling and redness around the wound",
      "possible exposure of underlying tissues or structures",
    ],
  ),
  MedicalTerm(
    term: "Lactose Intolerance",
    definition:
        "A digestive disorder caused by the inability to digest lactose, a sugar found in milk and dairy products.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "bloating",
      "diarrhea",
      "gas",
      "abdominal cramps",
      "nausea",
    ],
  ),
  MedicalTerm(
    term: "Laryngitis",
    definition:
        "An inflammation of the larynx (voice box) that can cause hoarseness or loss of voice.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "hoarseness or weak voice",
      "sore throat",
      "dry throat",
      "coughing",
      "difficulty speaking",
    ],
  ),
  MedicalTerm(
    term: "Lesion",
    definition:
        "An abnormal change in the structure of an organ or part due to injury or disease.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: ["pain", "swelling", "redness", "loss of function"],
  ),
  MedicalTerm(
    term: "Leukemia",
    definition:
        "A type of cancer that affects the blood and bone marrow, characterized by the overproduction of abnormal white blood cells.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "fatigue and weakness",
      "frequent infections",
      "easy bruising or bleeding",
      "unexplained weight loss",
      "swollen lymph nodes",
    ],
  ),
  MedicalTerm(
    term: "Lupus",
    definition:
        "A chronic autoimmune disease that can cause inflammation and damage to various parts of the body, including the skin, joints, kidneys, and other organs.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "fatigue",
      "joint pain and swelling",
      "skin rashes (often in a butterfly pattern across the cheeks and nose)",
      "fever",
      "hair loss",
      "sensitivity to sunlight",
    ],
  ),
  MedicalTerm(
    term: "Lymphoma",
    definition:
        "A type of cancer that begins in the lymphatic system, which is part of the immune system.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "swollen lymph nodes",
      "fever",
      "night sweats",
      "unexplained weight loss",
      "fatigue",
    ],
  ),
  MedicalTerm(
    term: "Malaria",
    definition:
        "A mosquito-borne infectious disease caused by Plasmodium parasites, leading to fever, chills, and flu-like symptoms.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "fever and chills",
      "headache",
      "muscle aches",
      "fatigue",
      "nausea and vomiting",
      "sweating",
    ],
  ),
  MedicalTerm(
    term: "Measles",
    definition:
        "A highly contagious viral infection that causes a distinctive red rash and flu-like symptoms.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "high fever",
      "cough",
      "runny nose",
      "red, watery eyes",
      "rash that usually starts on the face and spreads to the rest of the body",
    ],
  ),
  MedicalTerm(
    term: "Meningitis",
    definition:
        "An inflammation of the protective membranes covering the brain and spinal cord, usually caused by an infection.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "sudden high fever",
      "severe headache",
      "stiff neck",
      "nausea and vomiting",
      "sensitivity to light",
      "confusion or difficulty concentrating",
    ],
  ),
  MedicalTerm(
    term: "Migraine",
    definition:
        "A neurological condition characterized by intense, debilitating headaches.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "throbbing or pulsating headache",
      "sensitivity to light and sound",
      "nausea and vomiting",
      "visual disturbances (aura)",
      "fatigue and irritability",
    ],
  ),
  MedicalTerm(
    term: "Multiple Sclerosis (MS)",
    definition:
        "A chronic autoimmune disease that affects the central nervous system, leading to a wide range of symptoms.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "numbness or weakness in limbs",
      "partial or complete loss of vision",
      "double vision or blurring of vision",
      "tingling or pain in parts of the body",
      "fatigue",
      "dizziness and balance issues",
    ],
  ),
  MedicalTerm(
    term: "Nephritis",
    definition:
        "An inflammation of the kidneys, often caused by an infection or autoimmune disorder.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "fever",
      "fatigue",
      "nausea and vomiting",
      "swelling in the legs and feet",
      "decreased urine output",
      "blood in the urine",
    ],
  ),
  MedicalTerm(
    term: "Neuropathy",
    definition:
        "A condition resulting from damage to the peripheral nerves, causing weakness, numbness, and pain, usually in the hands and feet.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "numbness or tingling in the hands or feet",
      "sharp, burning, or shooting pain",
      "sensitivity to touch",
      "muscle weakness",
      "loss of coordination and balance",
    ],
  ),
  MedicalTerm(
    term: "Obesity",
    definition:
        "A medical condition characterized by excessive body fat that increases the risk of health problems.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "excessive body fat",
      "difficulty with physical activity",
      "shortness of breath",
      "fatigue",
      "joint pain",
    ],
  ),
  MedicalTerm(
    term: "Osteoarthritis",
    definition:
        "A degenerative joint disease that occurs when the protective cartilage on the ends of your bones wears down over time.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "joint pain and stiffness",
      "loss of flexibility",
      "grating sensation in the joint",
      "bone spurs",
      "swelling around the joint",
    ],
  ),
  MedicalTerm(
    term: "Osteoporosis",
    definition:
        "A condition in which bones become weak and brittle, making them more susceptible to fractures.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "back pain, caused by a fractured or collapsed vertebra",
      "loss of height over time",
      "stooped posture",
      "bone fractures that occur more easily than expected",
    ],
  ),
  MedicalTerm(
    term: "Otitis Media",
    definition:
        "An infection or inflammation of the middle ear, often caused by bacteria or viruses.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "ear pain",
      "fluid drainage from the ear",
      "hearing loss",
      "fever",
      "irritability in children",
    ],
  ),
  MedicalTerm(
    term: "Ovarian Cysts",
    definition:
        "Fluid-filled sacs or pockets within or on the surface of an ovary, often forming during ovulation.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "pelvic pain",
      "bloating or swelling in the abdomen",
      "painful periods",
      "pain during intercourse",
      "frequent urination",
    ],
  ),
  MedicalTerm(
    term: "Pancreatitis",
    definition:
        "An inflammation of the pancreas, usually caused by gallstones or heavy alcohol use.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "severe abdominal pain",
      "nausea and vomiting",
      "fever",
      "weight loss",
      "diarrhea",
    ],
  ),
  MedicalTerm(
    term: "Parkinson's Disease",
    definition:
        "A progressive nervous system disorder that affects movement, often including tremors.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "tremors or shaking",
      "slowed movement (bradykinesia)",
      "rigid muscles",
      "impaired posture and balance",
      "loss of automatic movements",
      "speech changes",
    ],
  ),
  MedicalTerm(
    term: "Pneumonia",
    definition:
        "An infection that inflames the air sacs in one or both lungs, which may fill with fluid or pus.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "cough, which may produce phlegm",
      "fever, sweating, and chills",
      "shortness of breath",
      "chest pain when breathing or coughing",
      "fatigue",
    ],
  ),
  MedicalTerm(
    term: "Polycystic Ovary Syndrome (PCOS)",
    definition:
        "A hormonal disorder common among women of reproductive age, characterized by irregular menstrual periods, excess androgen levels, and polycystic ovaries.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "irregular menstrual cycles",
      "excess hair growth (hirsutism)",
      "acne",
      "weight gain",
      "thinning hair or hair loss",
      "darkening of the skin, particularly along neck creases, in the groin, and underneath breasts",
    ],
  ),
  MedicalTerm(
    term: "Polio",
    definition:
        "A highly infectious viral disease that primarily affects young children and can lead to paralysis.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "fever",
      "fatigue",
      "headache",
      "vomiting",
      "stiffness in the neck and back",
      "pain in the limbs",
    ],
  ),
  MedicalTerm(
    term: "Post-Traumatic Stress Disorder (PTSD)",
    definition:
        "A mental health condition triggered by experiencing or witnessing a traumatic event, leading to severe anxiety, flashbacks, and uncontrollable thoughts about the event.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "severe anxiety",
      "flashbacks",
      "uncontrollable thoughts about the event",
    ],
  ),
  MedicalTerm(
    term: "Psoriasis",
    definition:
        "A chronic autoimmune condition that causes the rapid buildup of skin cells, leading to scaling and inflammation.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "red patches of skin covered with thick, silvery scales",
      "dry, cracked skin that may bleed",
      "itching, burning, or soreness",
      "thickened or ridged nails",
    ],
  ),
  MedicalTerm(
    term: "Pulmonary Embolism",
    definition:
        "A blockage in one of the pulmonary arteries in the lungs, usually caused by blood clots that travel to the lungs from the legs or other parts of the body.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "shortness of breath",
      "chest pain",
      "cough, which may produce bloody or blood-streaked sputum",
      "rapid heart rate",
      "lightheadedness or dizziness",
    ],
  ),
  MedicalTerm(
    term: "Rabies",
    definition:
        "A viral disease that causes inflammation of the brain in humans and other mammals.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "fever",
      "headache",
      "excessive salivation",
      "muscle spasms",
      "paralysis",
      "confusion",
      "hallucinations",
      "agitation",
    ],
  ),
  MedicalTerm(
    term: "Renal Failure",
    definition:
        "A condition in which the kidneys lose the ability to filter waste from the blood.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "decreased urine output",
      "swelling in legs, ankles, or feet",
      "fatigue",
      "confusion",
      "nausea and vomiting",
      "shortness of breath",
      "chest pain or pressure",
    ],
  ),
  MedicalTerm(
    term: "Rheumatoid Arthritis",
    definition:
        "A chronic inflammatory disorder that primarily affects the joints, leading to pain, swelling, and potential joint deformity.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "joint pain and tenderness",
      "swelling in the joints",
      "stiffness, especially in the morning or after periods of inactivity",
      "fatigue",
      "fever",
      "loss of appetite",
    ],
  ),
  MedicalTerm(
    term: "Sarcoma",
    definition:
        "A type of cancer that originates in the bones and soft tissues.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "a lump or swelling in the affected area",
      "pain in the affected area",
      "fatigue",
      "unexplained weight loss",
    ],
  ),
  MedicalTerm(
    term: "Scoliosis",
    definition:
        "A sideways curvature of the spine that occurs most often during the growth spurt just before puberty.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "uneven shoulders",
      "one shoulder blade that appears more prominent than the other",
      "uneven waist",
      "one hip higher than the other",
      "back pain (in adults)",
    ],
  ),
  MedicalTerm(
    term: "Sepsis",
    definition:
        "A life-threatening condition that arises when the body's response to an infection causes injury to its own tissues and organs.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "fever, chills, or feeling very cold",
      "rapid breathing and heart rate",
      "confusion or disorientation",
      "extreme pain or discomfort",
      "clammy or sweaty skin",
    ],
  ),
  MedicalTerm(
    term: "Stroke",
    definition:
        "A medical emergency that occurs when the blood supply to part of the brain is interrupted or reduced, preventing brain tissue from getting oxygen and nutrients.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "sudden numbness or weakness in the face, arm, or leg, especially on one side of the body",
      "sudden confusion, trouble speaking, or understanding speech",
      "sudden trouble seeing in one or both eyes",
      "sudden trouble walking, dizziness, loss of balance, or lack of coordination",
      "sudden severe headache with no known cause",
    ],
  ),
  MedicalTerm(
    term: "Systemic Lupus Erythematosus (SLE)",
    definition:
        "A chronic autoimmune disease that can affect various parts of the body, including the skin, joints, kidneys, and other organs.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "fatigue",
      "joint pain and swelling",
      "skin rashes (often in a butterfly pattern across the cheeks and nose)",
      "fever",
      "hair loss",
      "sensitivity to sunlight",
    ],
  ),
  MedicalTerm(
    term: "Tetanus",
    definition:
        " A serious bacterial infection that affects the nervous system, causing muscle contractions.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "muscle stiffness and spasms, often starting in the jaw (lockjaw)",
      "difficulty swallowing",
      "fever and sweating",
      "rapid heart rate",
      "high blood pressure",
    ],
  ),
  MedicalTerm(
    term: "Thrombosis",
    definition:
        "The formation of a blood clot inside a blood vessel, which can obstruct the flow of blood through the circulatory system.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "swelling in the affected area",
      "pain or tenderness in the affected area",
      "red or discolored skin",
      "warmth in the affected area",
      "shortness of breath (if the clot travels to the lungs)",
    ],
  ),
  MedicalTerm(
    term: "Thyroid Disorders",
    definition:
        "A group of conditions that affect the thyroid gland, which regulates metabolism, energy levels, and overall hormonal balance.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "fatigue",
      "weight changes (gain or loss)",
      "changes in heart rate",
      "sensitivity to cold or heat",
      "hair thinning or hair loss",
      "dry skin",
      "swelling in the neck (goiter)",
    ],
  ),
  MedicalTerm(
    term: "Tinnitus",
    definition:
        "The perception of noise or ringing in the ears, which can be a symptom of an underlying condition.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "ringing, buzzing, hissing, or whistling sounds in the ears",
      "hearing loss",
      "dizziness or balance issues",
      "headache",
      "ear pain or discomfort",
    ],
  ),
  MedicalTerm(
    term: "Tuberculosis (TB)",
    definition:
        "A potentially serious infectious disease that mainly affects the lungs, caused by the bacterium Mycobacterium tuberculosis.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "persistent cough that lasts three weeks or longer",
      "coughing up blood or sputum",
      "chest pain or pain with breathing or coughing",
      "unintentional weight loss",
      "fatigue",
      "fever",
      "night sweats",
      "chills",
      "loss of appetite",
    ],
  ),
  MedicalTerm(
    term: "Tumor",
    definition:
        "An abnormal growth of tissue that can be benign (non-cancerous) or malignant (cancerous).",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "a lump or mass that can be felt under the skin",
      "pain or tenderness in the affected area",
      "unexplained weight loss",
      "fatigue",
      "fever",
    ],
  ),
  MedicalTerm(
    term: "Ulcer",
    definition:
        "An open sore that develops on the skin or mucous membranes, often caused by infection, inflammation, or underlying medical conditions.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "pain or discomfort at the site of the ulcer",
      "redness and swelling around the ulcer",
      "bleeding or discharge from the ulcer",
      "slow healing of the affected area",
      "foul odor from the ulcer",
    ],
  ),
  MedicalTerm(
    term: "Urinary Tract Infection (UTI)",
    definition:
        "An infection in any part of the urinary system, including the kidneys, ureters, bladder, and urethra.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "a strong, persistent urge to urinate",
      "a burning sensation when urinating",
      "passing frequent, small amounts of urine",
      "cloudy or strong-smelling urine",
      "pelvic pain, especially in the center of the pelvis and around the area of the pubic bone",
    ],
  ),
  MedicalTerm(
    term: "Varicose Veins",
    definition:
        "Enlarged, twisted veins that often appear on the legs and feet due to weakened valves and veins.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "visible, bulging veins",
      "aching or heavy feeling in the legs",
      "swelling in the lower legs and ankles",
      "itching around the veins",
      "skin discoloration around the affected area",
    ],
  ),
  MedicalTerm(
    term: "Vertigo",
    definition:
        "A sensation of spinning or dizziness, often caused by problems in the inner ear or brain.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "a spinning sensation or feeling that you or your surroundings are moving",
      "loss of balance or unsteadiness",
      "nausea and vomiting",
      "ringing in the ears (tinnitus)",
      "headache",
    ],
  ),
  MedicalTerm(
    term: "Viral Infection",
    definition:
        "An infection caused by a virus, which can affect various parts of the body and lead to a range of symptoms.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "fever",
      "fatigue",
      "muscle aches",
      "coughing and sneezing",
      "sore throat",
      "runny or stuffy nose",
      "headache",
    ],
  ),
  MedicalTerm(
    term: "Yersiniosis",
    definition:
        "An infection caused by Yersinia bacteria, often resulting from contaminated food or water.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "diarrhea",
      "abdominal pain",
      "fever",
      "nausea and vomiting",
      "joint pain",
    ],
  ),
  MedicalTerm(
    term: "Zika Virus",
    definition:
        "A mosquito-borne virus that can cause fever, rash, joint pain, and conjunctivitis, and is particularly concerning for pregnant women due to the risk of birth defects.",
    secondSectionTitle: "Common Symptoms:",
    secondSectionItems: [
      "fever",
      "rash",
      "joint pain",
      "conjunctivitis (red eyes)",
      "muscle pain",
      "headache",
    ],
  ),
];
