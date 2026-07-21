class LabResult {
  final String testName;
  final String unit;
  final double minValue;
  final double maxValue;
  final String description;
  final String lowExplanation;
  final String highExplanation;
  final String normalExplanation;
  final List<String> notes;
  final String image;

  LabResult({
    required this.testName,
    required this.unit,
    required this.minValue,
    required this.maxValue,
    required this.description,
    required this.lowExplanation,
    required this.highExplanation,
    required this.normalExplanation,
    required this.notes,
    required this.image,
  });
}

final labResults = [
  LabResult(
    testName: "White Blood Cell (WBC) Count",
    unit: "x10³/µL",
    minValue: 4.5,
    maxValue: 11.0,
    description:
        "A White Blood Cell (WBC) count is a standard clinical test that measures the total number of immune cells circulating in your bloodstream.",
    lowExplanation:
        "Your body has fewer immune cells than average, which can temporarily weaken your defenses against illness. This drop is frequently caused by a recent viral infection that used up cells, certain prescription medications, or issues affecting how your bone marrow produces new cells.",
    highExplanation:
        "Your immune system has been triggered and your body is actively multiplying its cells to deal with a perceived threat. This spike most commonly happens when you are fighting off an infection, experiencing physical inflammation from an injury, or dealing with intense bodily stress.",
    normalExplanation:
        "Your body has a healthy, active baseline army of immune cells ready to defend against everyday germs, viruses, and bacteria. It indicates that your bone marrow is producing cells normally and there is no active, widespread infection triggering an alarm",
    notes: [
      "Natural Fluctuations: Counts shift throughout the day based on exercise, stress, age, and pregnancy.",
      "Temporary Changes: A single abnormal reading usually indicates a temporary recovery from a mild cold rather than a serious illness.",
      "Lab Reference Variations: Baseline ranges vary slightly between different hospitals depending on the specific testing equipment they use.",
    ],
    image: "assets/images/WBC.png",
  ),
  LabResult(
    testName: "Red Blood Cell (RBC) Count",
    unit: "x10⁶/µL",
    minValue: 3.8,
    maxValue: 5.9,
    description:
        "A Red Blood Cell (RBC) count is a standard blood test that measures the total number of oxygen-carrying cells circulating in your body to evaluate how efficiently your vital organs are receiving oxygen and to screen for conditions like anemia.",
    lowExplanation:
        "A low count means your body may not be getting enough oxygen, which can cause persistent fatigue, dizziness, or shortness of breath, and is often linked to iron deficiencies or recent blood loss.",
    highExplanation:
        "A high count indicates an overproduction of red blood cells, which can thicken your blood and is commonly triggered by long-term smoking, sleep apnea, living at a high altitude, or simple dehydration.",
    normalExplanation:
        "Your red blood cell levels are well-balanced, indicating that your body is effectively producing and delivering a healthy supply of oxygen to all of your tissues and organs",
    notes: [
      "Kidney Health Link: Your kidneys produce the hormone that triggers red blood cell production, so kidney issues directly cause your numbers to drop.",
      "Nutritional Impact: Your body requires iron, vitamin B12, and folate to make these cells, meaning a poor diet quickly lowers your count.",
      "Cell Lifespan: Red blood cells naturally wear out and get replaced every 120 days, causing counts to drop if destruction outpaces production.",
    ],
    image: "assets/images/RBC.png",
  ),
  LabResult(
    testName: "Hemoglobin (HGB)",
    unit: "g/dL",
    minValue: 12.0,
    maxValue: 17.5,
    description:
        "A Hemoglobin (HGB) test is a standard blood test that measures the total amount of the iron-rich, oxygen-carrying protein inside your red blood cells to evaluate how effectively your blood is transporting oxygen to your tissues and organs",
    lowExplanation:
        "A low hemoglobin count, known as anemia, means your blood lacks enough oxygen-carrying protein to efficiently deliver fuel to your body's tissues and vital organs.",
    highExplanation:
        "A high hemoglobin count, known as erythrocytosis, means your blood has an overabundance of oxygen-carrying proteins, which often thickens your bloodstream and increases cardiovascular strain",
    normalExplanation:
        "A normal hemoglobin count means your blood contains a well-balanced amount of oxygen-carrying protein to efficiently deliver fuel to all of your body's tissues and vital organs.",
    notes: [
      "Hydration Influence: Dehydration artificially spikes your hemoglobin reading by shrinking the liquid portion of your blood, while overhydration dilutes it.",
      "Altitude Adaptation: Living or training at high altitudes forces your body to naturally produce more hemoglobin over time.",
      "Daily Fluctuations: Your hemoglobin levels naturally shift throughout the day, typically peaking in the morning and dropping in the evening.",
      "Gender Differences: Biological males naturally maintain higher hemoglobin levels due to testosterone production, while biological females tend to have lower baseline levels due to estrogen and regular menstrual cycles.",
    ],
    image: "assets/images/HGB.png",
  ),
  LabResult(
    testName: "Platelet (PLT) Count",
    unit: "x10³/µL",
    minValue: 150,
    maxValue: 450,
    description:
        "A Platelet Count (PLT) test is a standard blood test that measures the total number of tiny cell fragments in your bloodstream to evaluate how effectively your blood can form clots and stop bleeding.",
    lowExplanation:
        "A low platelet count, known as thrombocytopenia, means your blood lacks enough cell fragments to clot properly, which increases your risk of prolonged bleeding or bruising from minor injuries.",
    highExplanation:
        "A high platelet count, known as thrombocytosis, means your blood has an overabundance of clotting cells, which can thicken your bloodstream and increase your risk of developing dangerous blood clots.",
    normalExplanation:
        "A normal platelet count means your blood contains a well-balanced number of clotting cells to effectively repair blood vessel damage and protect you from both excessive bleeding and dangerous blood clots.",
    notes: [
      "Clotting Lifespan: Platelets only survive in your bloodstream for about 7 to 10 days, meaning your bone marrow must constantly manufacture new ones to maintain a stable count.",
      "Splenic Regulation: Your spleen naturally stores about one-third of your body's platelets, but a damaged or enlarged spleen can trap too many cells and lower your circulating count.",
      "Temporary Spikes: Your platelet count can naturally spike for a few weeks following an acute injury, surgery, or major physical trauma as your body rushes to boost its healing defenses.",
    ],
    image: "assets/images/PLT.png",
  ),
  LabResult(
    testName: "Hematocrit (HCT) ",
    unit: "%",
    minValue: 36,
    maxValue: 52,
    description:
        "A Hematocrit (HCT) test is a standard blood test that measures the exact percentage of your total blood volume that is made up of red blood cells to evaluate your blood's thickness and oxygen-carrying capacity.",
    lowExplanation:
        "A low hematocrit level, known as anemia, means that red blood cells make up a smaller percentage of your total blood volume than normal, which reduces your body's ability to efficiently deliver oxygen to its tissues and vital organs.",
    highExplanation:
        "A high hematocrit level, known as erythrocytosis, means red blood cells make up an abnormally large percentage of your blood volume, which thickens your bloodstream and forces your heart to work harder to circulate it.",
    normalExplanation:
        "A normal hematocrit level means your bloodstream contains a well-balanced percentage of red blood cells, ensuring your blood is the ideal thickness to flow smoothly while efficiently delivering oxygen throughout your body.",
    notes: [
      "Hydration Influence: Dehydration artificially spikes your hematocrit percentage by lowering your liquid blood volume, while overhydration dilutes the blood and makes your percentage appear lower.",
      "Altitude Adaptation: Living or training in high-altitude environments forces your body to produce a higher percentage of red blood cells to adapt to lower oxygen levels.",
      "Gender Variations: Biological males naturally maintain a higher normal hematocrit percentage due to testosterone, while biological females tend to have lower baseline percentages.",
    ],
    image: "assets/images/HCT.png",
  ),
  LabResult(
    testName: "Glucose",
    unit: "mg/dL",
    minValue: 70,
    maxValue: 99,
    description:
        "A Glucose test is a standard blood test that measures the exact amount of sugar circulating in your bloodstream to evaluate how efficiently your body metabolizes energy and to screen for conditions like pre-diabetes and diabetes.",
    lowExplanation:
        "A low glucose level, known as hypoglycemia, means your blood sugar has dropped below the minimum amount required to fuel your brain and muscles, which can trigger acute weakness, sweating, and dizziness.",
    highExplanation:
        "A high glucose level, known as hyperglycemia, means your blood contains an overabundance of sugar, which indicates that your body is either not producing enough insulin or cannot use it effectively to convert food into cellular energy.",
    normalExplanation:
        "A normal glucose level means your body is perfectly balancing insulin and blood sugar, ensuring your brain and muscles have a steady, healthy supply of energy to function correctly.",
    notes: [
      "Fasting Requirement: Eating food before a basic metabolic panel artificially spikes your blood sugar, which can lead to a false high result on your lab report.",
      "Stress Impact: Sudden emotional or physical stress triggers the release of cortisol, a hormone that temporarily forces extra glucose into your bloodstream.",
      "Medication Influence: Common prescription drugs like steroids can rapidly raise your blood sugar levels, while certain blood pressure medications can subtly lower them.",
      "Condition Baselines: Users diagnosed with diabetes or pre-diabetes will naturally have higher target ranges set by their doctor compared to the standard fasting values shown on a basic lab panel.",
    ],
    image: "assets/images/Glucose.png",
  ),
  /*LabResult(
      testName: testName, 
      unit: unit, 
      minValue: minValue, 
      maxValue: maxValue, 
      description: description, 
      lowExplanation: lowExplanation, 
      highExplanation: highExplanation, 
      normalExplanation: normalExplanation, 
      notes: notes, 
      image: image
      )
      */
];
