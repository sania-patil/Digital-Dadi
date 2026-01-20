PREGNANCY_DANGER = [
    "water break", "labour pain", "bleeding", "pani nikal"
]

POSTPARTUM_DANGER = [
    "heavy bleeding", "bukhar", "bahut kamzori"
]

def risk_node(state):
    msg = state["message"].lower()

    danger_words = (
        PREGNANCY_DANGER if state["mother_stage"] == "pregnancy"
        else POSTPARTUM_DANGER
    )

    if any(w in msg for w in danger_words):
        state["risk_level"] = "high"
    elif state["intent"] == "emotional":
        state["risk_level"] = "medium"
    else:
        state["risk_level"] = "low"

    return state
