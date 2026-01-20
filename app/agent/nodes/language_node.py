import re

def language_node(state):
    msg = state["message"]
    
    # Check for Devanagari script (Hindi)
    devanagari_pattern = r'[\u0900-\u097F]'
    if re.search(devanagari_pattern, msg):
        state["language"] = "hi"
    # Check for transliterated Hindi keywords
    elif any(w in msg.lower() for w in ["mujhe", "dard", "dar", "baccha", "pani"]):
        state["language"] = "hi"
    else:
        state["language"] = "en"

    return state
