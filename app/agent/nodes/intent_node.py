import re

def intent_node(state):
    msg = state["message"].lower()
    
    # Check for recipe intent
    if any(w in msg for w in ["recipe", "khana", "banane", "rasoi"]):
        state["intent"] = "recipe"
    # Check for emotional intent - include both transliterated and Devanagari keywords
    elif any(w in msg for w in ["dar", "lonely", "anxious", "ghabra", "akelap", "udas", "dukh"]):
        state["intent"] = "emotional"
    # Check for Devanagari emotional keywords
    elif re.search(r"(अकेल|उदास|दुख|भय|डर|चिंत|परेश)", msg):
        state["intent"] = "emotional"
    else:
        state["intent"] = "guidance"

    return state
