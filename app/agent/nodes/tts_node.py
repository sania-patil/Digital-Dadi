from app.services.tts_service import text_to_speech

def tts_node(state):
    """
    TTS node: converts response text to audio
    """

    state["audio_url"] = text_to_speech(
        text=state["response_text"],
        language=state["language"],
        use_elevenlabs=True
    )

    return state
