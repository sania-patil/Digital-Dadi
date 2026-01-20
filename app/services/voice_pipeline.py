import os
from openai import OpenAI
import requests
from dotenv import load_dotenv
load_dotenv()
client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))

def speech_to_text(audio_path: str) -> str:
    """
    Convert user audio to text using Whisper
    """
    with open(audio_path, "rb") as audio_file:
        transcription = client.audio.transcriptions.create(
            file=audio_file,
            model="whisper-1"
        )
    return transcription.text

print(speech_to_text("D:/Digital_Dadi/backend/temp/demo aji.wav"))


EMOTION_PROMPTS = {
    "lonely": "Comfort the user deeply. Speak slowly and warmly.",
    "anxious": "Reassure the user. Reduce fear. Be calming.",
    "tired": "Encourage rest. Be gentle and caring.",
    "normal": "Speak lovingly like a grandmother."
}

SYSTEM_PROMPT = """
You are Digital Dadi, a 70-year-old Indian grandmother.
    {EMOTION_PROMPTS[emotion]}
    Use Hindi/Hinglish.
    Short sentences. Pauses.
    """
# You speak slowly, emotionally, and lovingly.
# You use Hindi/Hinglish.
# You comfort, not lecture.
def dadi_llm_response(user_text: str, state: dict) -> str:
    """
    Generate emotional Dadi-style response
    """
    response = client.chat.completions.create(
        model="gpt-4o",
        messages=[
            {"role": "system", "content": SYSTEM_PROMPT},
            {"role": "user", "content": user_text}
        ]
    )

    return response.choices[0].message.content

# print(dadi_llm_response("Mujhe akela lag raha hai", {}))

# def text_to_speech(dadi_text: str) -> str:
#     """
#     Convert Dadi text to old emotional voice
#     """
#     url = "https://api.elevenlabs.io/v1/text-to-speech/82Sq3U3fQX7AoREdxktm"

#     headers = {
#         "xi-api-key": os.getenv("ELEVENLABS_API_KEY"),
#         "Content-Type": "application/json"
#     }

#     payload = {
#         "text": dadi_text,
#         "voice_settings": {
#             "stability": 45,
#             "similarity_boost": 85
#         }
#     }

#     response = requests.post(url, json=payload, headers=headers)

#     output_path = "dadi_output.mp3"
#     with open(output_path, "wb") as f:
#         f.write(response.content)

#     return output_path

# text_to_speech("Beta… thoda aaram kar lo…")



def text_to_speech(dadi_text: str) -> str:
    """
    Convert Dadi text to old emotional voice (WAV format)
    """
    url = "https://api.elevenlabs.io/v1/text-to-speech/82Sq3U3fQX7AoREdxktm?output_format=wav"

    headers = {
        "xi-api-key": os.getenv("ELEVENLABS_API_KEY"),
        "Content-Type": "application/json"
    }

    payload = {
        "text": dadi_text,
        "voice_settings": {
            "stability": 45,
            "similarity_boost": 85
        }
    }

    response = requests.post(url, json=payload, headers=headers)

    output_path = "dadi_output.wav"
    with open(output_path, "wb") as f:
        f.write(response.content)

    return output_path


def run_voice_pipeline(audio_path: str, state: dict) -> dict:
    """
    Full pipeline: audio → text → dadi response → audio
    """
    user_text = speech_to_text(audio_path)
    dadi_text = dadi_llm_response(user_text, state)
    audio_file = text_to_speech(dadi_text)

    return {
        "user_text": user_text,
        "dadi_text": dadi_text,
        "audio_file": audio_file
    }



if __name__ == "__main__":
    print("Running voice_pipeline test...")

    # 1️⃣ Test speech to text
    text = speech_to_text("D:/Digital_Dadi/backend/temp/demo aji.wav")
    print("STT OUTPUT:", text)

    # 2️⃣ Test text to speech (as developer mentioned)
    audio_path = text_to_speech("Beta… thoda aaram kar lo…")
    print("TTS OUTPUT FILE:", audio_path)
