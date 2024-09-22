import asyncio
import websockets
import game

game = game.Game()
players = set()

async def update(websocket, path):
    while True:
        await websocket.send(game.get_current_frame())
        await asyncio.sleep(0.01)

async def receive(websocket, path, player):
    async for message in websocket:
        game.command(message, player)

async def handler(websocket, path):
    player_no = game.new_player()
    players.add((websocket, player_no))
    try:
        receive_task = asyncio.ensure_future(
            receive(websocket, path, player_no))
        update_task = asyncio.ensure_future(
            update(websocket, path))
        done, pending = await asyncio.wait(
            [receive_task, update_task],
            return_when=asyncio.FIRST_COMPLETED)
        for task in pending:
            task.cancel()
    finally:
        players.remove((websocket, player_no))
        game.remove_player(player_no)

start_server = websockets.serve(handler, '0.0.0.0', 8765)

asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()
