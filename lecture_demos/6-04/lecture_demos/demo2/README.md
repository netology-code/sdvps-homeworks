# OnlineSnake.fun

OnlineSnake.fun is a small fun multiplayer browser game.

### Background
This project was started when I was volunteering at the [Junction 2018](https://hackjunction.com/). I wanted to try out real-time web programming with websockets and decided to make a simple game. This is the result.

### Development setup
#### Docker container
In project repository, run `docker-compose up`. After the container is ready, navigate to [localhost:8080](http://localhost:8080) using your web browser. If you make changes to web files (client), refresh the web page to see the effect. If you change server files (python), rebuild (`docker-compose build`) and restart the docker container to see changes.

#### Without Docker
In project repository execute following commands (for Windows setup or additional information about using venv, see [https://docs.python.org/3/library/venv.html](https://docs.python.org/3/library/venv.html)):
```bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python3 snake.py
```
You should now have the websocket backend running. Next, use your text editor to change the websocket port from [web/game.js](./web/game.js): change line `var wsurl = "ws://localhost:8080/websocket/";` to `var wsurl = "ws://localhost:8765/websocket/";`. Make sure not to commit this port change accidentally!
Now open the index.html page with your browser, no setup for web server needed. Similarly to development with docker, refresh the index.html web page when making changes to web files, and restart the snake.py server (use ctrl-c to kill current process) if you change server-side files.
