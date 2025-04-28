import os
import sys
import logging

from telegram import Update
from telegram.ext import ApplicationBuilder, CommandHandler, MessageHandler, filters, ContextTypes
from msg_queue import Queue

sys.path.insert(0, './objection_engine')

logging.basicConfig(
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    level=logging.INFO
)
logger = logging.getLogger(__name__)

queueList = {}

async def start(update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
    await update.message.reply_text(
        'Hi! This is a bot that will transform a group of Telegram messages into Ace Attorney scenes. Just forward me the messages.'
    )

async def about_command(update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
    await update.message.reply_text(
        'Made with ❤ by @TLuigi003.\nSource code in https://github.com/LuisMayo/ace-attorney-telegram-bot\n\n'
        'Do you like my work? You could thank me by buying me a [ko-fi](https://ko-fi.com/luismayo)',
        parse_mode="Markdown"
    )

async def getMessage(update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
    global app
    if update.message.chat.id not in queueList or queueList[update.message.chat.id] is None:
        queueList[update.message.chat.id] = Queue(update, queueList, app)
    queueList[update.message.chat.id].addMessage(update)

def main():
    token = os.environ["BOT_TOKEN"]
    global app
    app = ApplicationBuilder().token(token).build()

    app.add_handler(CommandHandler("start", start))
    app.add_handler(CommandHandler("about", about_command))
    app.add_handler(MessageHandler(
        (filters.TEXT | filters.PHOTO | filters.STICKER) & ~filters.COMMAND,
        getMessage
    ))

    app.run_polling()

if __name__ == '__main__':
    main()
