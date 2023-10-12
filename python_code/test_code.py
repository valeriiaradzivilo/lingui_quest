import numpy as np
from flask import Flask

app = Flask(__name__)

@app.route('/create_test', methods = ['GET'])
def api_solve():
    print('I am')
    return 'here'

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=False)