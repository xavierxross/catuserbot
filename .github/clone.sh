#!/bin/bash

# Copyright (C) 2020 by sandy1709

echo "
                    :'######:::::'###::::'########::::
                    '##... ##:::'## ##:::... ##..:::::
                     ##:::..:::'##:. ##::::: ##:::::::
                     ##:::::::'##:::. ##:::: ##:::::::
                     ##::::::: #########:::: ##:::::::
                     ##::: ##: ##.... ##:::: ##:::::::
                    . ######:: ##:::: ##:::: ##:::::::
                    :......:::..:::::..:::::..::::::::
"

echo "
'##::::'##::'######::'########:'########::'########:::'#######::'########:
 ##:::: ##:'##... ##: ##.....:: ##.... ##: ##.... ##:'##.... ##:... ##..::
 ##:::: ##: ##:::..:: ##::::::: ##:::: ##: ##:::: ##: ##:::: ##:::: ##::::
 ##:::: ##:. ######:: ######::: ########:: ########:: ##:::: ##:::: ##::::
 ##:::: ##::..... ##: ##...:::: ##.. ##::: ##.... ##: ##:::: ##:::: ##::::
 ##:::: ##:'##::: ##: ##::::::: ##::. ##:: ##:::: ##: ##:::: ##:::: ##::::
. #######::. ######:: ########: ##:::. ##: ########::. #######::::: ##::::
:.......::::......:::........::..:::::..::........::::.......::::::..:::::
"

if [[ -n $HEROKU_API_KEY && -n $HEROKU_APP_NAME ]]; then
    herokuErr=$(python ./.github/herokugiturl.py)
    if [[ "$herokuErr" ]]; then 
        echo "$herokuErr"
    else
        HEROKU_GIT_URL="https://api:$HEROKU_API_KEY@git.heroku.com/$HEROKU_APP_NAME.git"
        echo "$HEROKU_GIT_URL"
    fi
fi

FILE=/app/.git

if [ -d "$FILE" ] ; then
    echo "$FILE directory exists already."
else
    if [[ "$HEROKU_GIT_URL" ]]; then
        {
          git clone "$HEROKU_GIT_URL" cat_ubh
          mv cat_ubh/.git .
          rm -rf cat_ubh
        } || {
          git init
        }
    else
        git init
    fi
fi

FILE=/app/bin/

if [ -d "$FILE" ] ; then
    echo "$FILE directory exists already."
else
    mkdir /app/bin/
    # downloading bins
    wget -O /app/bin/megadown https://raw.githubusercontent.com/adekmaulana/megadown/master/megadown
    wget -O /app/bin/cmrudl https://raw.githubusercontent.com/yshalsager/cmrudl.py/master/cmrudl.py
    # changing bins permissions
    chmod 755 bin/megadown
    chmod 755 bin/cmrudl 
    echo "Succesfully bins are added"
fi

python -m userbot
