if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g fish_greeting

function fish_greeting
    set -l furinaQuotes \
        "Why are you just standing there with your mouth gaping? Ah, you must be stunned and at a loss for words... Understandable, it is I after all... Fontaine's most beloved star, Furina. I'm on a very tight schedule, so you're lucky to even get an appointment with me." \
        "Tea parties are a must for the well-mannered. If you'd like to learn the proper etiquette, I'd be happy to teach you." \
        "Boring... Isn't there anything else more interesting to do?" \
        "*sigh* Being too popular can be such a hassle. Who knew the people would adore me so much?" \
        "It's pouring out here! Wait, the water levels aren't rising, are they?" \
        "Wow, this would be the perfect location for shooting a film." \
        "The sun feels almost as hot as those studio lights I'm in front of all the time... Good thing there can only be one sun." \
        "\"Listen, there is a disturbing growling in the wind. That's the sound of a long-forgotten sea monster having a nightmare.\" Huh? Why is it having a nightmare? Uh... I dunno, because fear has to manifest itself somehow?" \
        "What a wild and desolate sight... Allow me to grant you the blessing of water!"

    set -l index (random 1 (count $furinaQuotes))
    #printf '%.0s─' (seq $COLUMNS)
    #echo (set_color cyan)Furina: (set_color normal) $furinaQuotes[$index]
    #printf '%.0s─' (seq $COLUMNS)
    cowsay -f /home/paul/.config/assets/.furina.cow $furinaQuotes[$index]
end

alias dotfiles '/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
