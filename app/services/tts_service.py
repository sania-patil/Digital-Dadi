import uuid
from pathlib import Path
import asyncio
import os
from edge_tts import Communicate
from elevenlabs.client import ElevenLabs
from elevenlabs import Voice, VoiceSettings
from dotenv import load_dotenv

load_dotenv()
AUDIO_DIR = Path("app/storage/audio")
AUDIO_DIR.mkdir(parents=True, exist_ok=True)

def text_to_speech(text, language, use_elevenlabs=False):
    """
    Generate speech from text.
    
    Args:
        text: Text to convert to speech
        language: Language code ('en' or 'hi')
        use_elevenlabs: Use ElevenLabs for TTS (default: False)
    
    Returns:
        Path to audio file
    """
    filename = f"dadi_{uuid.uuid4()}.wav"
    filepath = AUDIO_DIR / filename

    if use_elevenlabs:
        return _generate_speech_elevenlabs(text, filepath, filename)
    else:
        return _generate_speech_edge(text, language, filepath, filename)

def _generate_speech_edge(text, language, filepath, filename):
    """Generate speech using Edge TTS"""
    # Use Indian English female voice for natural Indian accent
    voice = "en-IN-NeerjaNeural" if language == "en" else "hi-IN-SwaraNeural"
    
    # Run async function
    async def generate_speech():
        communicate = Communicate(text, voice)
        await communicate.save(str(filepath))
    
    asyncio.run(generate_speech())
    return f"/audio/{filename}"

# def _generate_speech_elevenlabs(text, filepath, filename):
#     """Generate speech using ElevenLabs with Dadi voice"""
#     api_key = os.getenv("ELEVENLABS_API_KEY")
#     voice_id = os.getenv("ELEVENLABS_VOICE_ID")
    
#     if not api_key:
#         raise ValueError("ELEVENLABS_API_KEY environment variable not set")
#     if not voice_id:
#         raise ValueError("ELEVENLABS_VOICE_ID environment variable not set")
    
#     client = ElevenLabs(api_key=api_key)
    
#     # Use configured voice ID - Elderly Indian woman voice
#     audio = client.generate(
#         text=text,
#         voice=Voice(
#             voice_id=voice_id,
#             settings=VoiceSettings(
#                 stability=0.5,
#                 similarity_boost=0.75,
#             ),
#         ),
#         model="eleven_monolingual_v1",
#     )
    
#     # Save audio to file
#     with open(filepath, "wb") as f:
#         for chunk in audio:
#             f.write(chunk)
    
#     return f"/audio/{filename}"

# def _generate_speech_elevenlabs(text, filepath, filename):
#     """Generate speech using ElevenLabs with emotional Dadi voice"""
#     api_key = os.getenv("ELEVENLABS_API_KEY")
#     voice_id = os.getenv("ELEVENLABS_VOICE_ID")

#     if not api_key:
#         raise ValueError("ELEVENLABS_API_KEY environment variable not set")
#     if not voice_id:
#         raise ValueError("ELEVENLABS_VOICE_ID environment variable not set")

#     client = ElevenLabs(api_key=api_key)

#     audio = client.generate(
#         text=text,
#         voice=Voice(
#             voice_id=voice_id,
#             settings=VoiceSettings(
#                 stability=0.65,              # natural pauses
#                 similarity_boost=0.85,       # keeps dadi personality
#                 style=0.9,                   # 🔥 emotion control
#                 use_speaker_boost=True       # warm presence
#             ),
#         ),
#         model="eleven_multilingual_v2",      # ✅ CORRECT MODEL
#     )

#     with open(filepath, "wb") as f:
#         for chunk in audio:
#             f.write(chunk)

#     return f"/audio/{filename}"

def _generate_speech_elevenlabs(text, filepath, filename):
    """Generate speech using ElevenLabs (new SDK)"""

    print("API KEY LOADED:", os.getenv("ELEVENLABS_API_KEY")[:8])
    print("VOICE ID LOADED:", os.getenv("ELEVENLABS_VOICE_ID"))

    api_key = os.getenv("ELEVENLABS_API_KEY")
    voice_id = os.getenv("ELEVENLABS_VOICE_ID")

    if not api_key:
        raise ValueError("ELEVENLABS_API_KEY environment variable not set")
    if not voice_id:
        raise ValueError("ELEVENLABS_VOICE_ID environment variable not set")

    client = ElevenLabs(api_key=api_key)

    audio = client.text_to_speech.convert(
        voice_id=voice_id,
        model_id="eleven_multilingual_v2",
        text=text,
        voice_settings={
            "stability": 0.65,
            "similarity_boost": 0.85,
            "style": 0.9,
            "use_speaker_boost": True
        }
    )

    with open(filepath, "wb") as f:
        for chunk in audio:
            f.write(chunk)

    return f"/audio/{filename}"
