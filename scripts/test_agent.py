import sys
from pathlib import Path

# Add backend root to Python path
sys.path.insert(0, str(Path(__file__).parent.parent))

from app.agent.graph import agent

# Minimal input — agent must think on its own
state = {
    "user_id": "u1",
    "message": "ab main kya khana prefer kru?",  # Recipe question in Hindi
    "mother_stage": "pregnancy",
    "week_number": 28,
    "language": "hi",
}

result = agent.invoke(state)

print("\n--- AGENT FULL STATE ---")
for k, v in result.items():
    print(f"{k}: {v}")

print("\n--- DADI'S REPLY (TEXT) ---")
print(result.get("response_text", "No response generated"))

print("\n--- DADI'S VOICE (URL) ---")
print(result.get("audio_url", "No audio generated"))
