from fastapi import FastAPI
from datetime import datetime
app = FastAPI(title="Digital Dadi Backend")

@app.get("/")
def root():
    return {"message": "Digital Dadi backend running"}

@app.post("/emergency-log")
def log_emergency(user_id: str, type: str):
    return {
        "user": user_id,
        "type": type,
        "time": datetime.now()
    }