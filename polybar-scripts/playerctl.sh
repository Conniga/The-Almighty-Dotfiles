playerctl --player=playerctld metadata --format '{{ title }} - {{ artist }}' 2>&1 | sed 's/No player could handle this command/Not playing.../g'
