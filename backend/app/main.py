from fastapi import FastAPI,Form
from datetime import datetime
app = FastAPI(title="Digital Dadi Backend")

@app.get("/")
def root():
    return {"message": "Digital Dadi backend running"}

@app.post("/emergency-log")
def log_emergency(
    user_id: str = Form(...),
    type: str = Form(...)
):
    print("POST /emergency-log")
    print(f"user_id={user_id} type={type}")
    return {
        "status": "logged",
        "user_id": user_id,
        "type": type,
        "time": datetime.now().isoformat()
    }
