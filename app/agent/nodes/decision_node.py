def decision_node(state):
    if state["risk_level"] == "high":
        state["strategy"] = "escalate"
    elif state["intent"] == "emotional":
        state["strategy"] = "reassure"
    else:
        state["strategy"] = "guide"

    return state
