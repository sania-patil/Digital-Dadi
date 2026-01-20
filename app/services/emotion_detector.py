def detect_emotion(text: str) -> str:
    text = text.lower()

    if any(word in text for word in ["akela", "lonely", "koi nahi", "bore"]):
        return "lonely"
    if any(word in text for word in ["dar", "tension", "ghabrahat"]):
        return "anxious"
    if any(word in text for word in ["thak", "neend", "kamzor"]):
        return "tired"

    return "normal"
