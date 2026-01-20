from app.services.llm_service import generate_dadi_reply

def llm_node(state):
    """
    LLM node: converts agent decision + context into human-like Dadi speech
    """

    state["response_text"] = generate_dadi_reply(
        message=state["message"],
        mother_stage=state["mother_stage"],
        week_number=state["week_number"],
        language=state["language"],
        intent=state["intent"],
        strategy=state["strategy"]
    )

    return state
