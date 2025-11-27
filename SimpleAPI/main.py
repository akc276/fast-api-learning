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

@app.get('/user/admin')
def admin():
    return {
        'Admin page'
    }

@app.get('/user/{user}')
def user():
    return {
        f'page for {user}'
    }

@app.get('/user/teacher/{teacher}')
def teacher(teacher='Mahesh'):
    return {
        'page for teacher {teacher}'
    }

@app.get('/products')
def products(id, price):
    return {
        f"id: {id}, price: {price}"
    }