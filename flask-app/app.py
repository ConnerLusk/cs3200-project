from src import create_app

# create the app object
app = create_app()

if __name__ == '__main__':
    app.run(debug = True, host = '0.0.0.0', port = 4000)