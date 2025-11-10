from fastapi import FastAPI

app = FastAPI()

@app.get('/')
def index():
    return 'Hello world!'

@app.get('/property')
def property():
    return 'This is property page'

@app.get('/movies')
def movies():
    return {
        'movie list': {'Movie1', 'Movie2'}
    }