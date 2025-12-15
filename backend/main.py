from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import List

app = FastAPI(title="Sxodim API")

# Разрешаем подключение с Flutter
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

# ─────────── MODELS ───────────
class Event(BaseModel):
    id: int
    title: str
    date: str
    time: str
    price: str
    place: str
    image: str
    description: str
    organizer: str

class User(BaseModel):
    email: str
    password: str

class Settings(BaseModel):
    push_notifications: bool = True

# ─────────── DATA ───────────
EVENTS: List[Event] = []
USERS: List[User] = []
USER_SETTINGS = {}  # ключ: email, значение: Settings

# ─────────── EVENTS ───────────
@app.get("/api/events")
def get_events():
    return EVENTS

@app.post("/api/events")
def add_event(event: Event):
    EVENTS.append(event)
    return {"success": True}

@app.put("/api/events/{event_id}")
def update_event(event_id: int, event: Event):
    for i, e in enumerate(EVENTS):
        if e.id == event_id:
            EVENTS[i] = event
            return {"success": True}
    raise HTTPException(status_code=404, detail="Event not found")

@app.delete("/api/events/{event_id}")
def delete_event(event_id: int):
    for i, e in enumerate(EVENTS):
        if e.id == event_id:
            EVENTS.pop(i)
            return {"success": True}
    raise HTTPException(status_code=404, detail="Event not found")

# ─────────── AUTH ───────────
@app.post("/api/register")
def register(user: User):
    for u in USERS:
        if u.email == user.email:
            raise HTTPException(status_code=400, detail="User already exists")
    USERS.append(user)
    USER_SETTINGS[user.email] = Settings()  # default settings
    return {"success": True}

@app.post("/api/login")
def login(user: User):
    for u in USERS:
        if u.email == user.email and u.password == user.password:
            return {"success": True}
    raise HTTPException(status_code=401, detail="Invalid credentials")

# ─────────── USER SETTINGS ───────────
@app.get("/api/{user_email}/settings")
def get_settings(user_email: str):
    settings = USER_SETTINGS.get(user_email)
    if settings:
        return settings
    raise HTTPException(status_code=404, detail="User not found")

@app.put("/api/{user_email}/settings")
def update_settings(user_email: str, settings: Settings):
    if user_email in USER_SETTINGS:
        USER_SETTINGS[user_email] = settings
        return {"success": True}
    raise HTTPException(status_code=404, detail="User not found")

# ─────────── RUN SERVER ───────────
if __name__ == "__main__":
    import uvicorn
    uvicorn.run("main:app", host="127.0.0.1", port=8000, reload=True)
