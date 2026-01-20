from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles
from app.agent.graph import agent

app = FastAPI(title="Digital Dadi")

app.mount("/audio", StaticFiles(directory="app/storage/audio"), name="audio")

@app.post("/agent/chat")
def chat(payload: dict):
    result = agent.invoke(payload)

    return {
        "audio_url": result["audio_url"],
        "risk_level": result["risk_level"]
    }
