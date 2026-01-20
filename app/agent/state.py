from typing import TypedDict

class AgentState(TypedDict):
    user_id: str
    message: str

    mother_stage: str        # "pregnancy" | "postpartum"
    week_number: int

    language: str            # "hi" | "en"
    intent: str              # guidance | emotional | recipe | daily
    risk_level: str          # low | medium | high
    strategy: str            # reassure | guide | escalate

    response_text: str
    audio_url: str
