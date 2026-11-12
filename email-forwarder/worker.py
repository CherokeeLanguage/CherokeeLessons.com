import asyncio
from workers import WorkerEntrypoint

class Default(WorkerEntrypoint):
    async def email(self, message, env, ctx):
        await asyncio.gather(
            message.forward("m.conrad.202+ia@gmail.com"),
            message.forward("standtrooper+ia@gmail.com"),
        )
