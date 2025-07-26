set -U fish_greeting "Use the command line to insert it, Master~"

function fish_prompt
    set -l last_status $status
    set -l purple (set_color -o 957DAD)
    set -l violet (set_color -o D291BC)
    set -l blue (set_color -o 0077C8)
    set -l red (set_color -o F78C8C)
    set -l normal (set_color normal)

    if test $last_status -ne 0
        printf '%s⨯%s ' $red $normal
    end

    printf '%s%s ' $blue $normal

    set -l cwd (string replace -r '^'$HOME '~' $PWD)
    printf '%s%s%s ' $purple $cwd $normal

    if type -q git
        set -l git_info (command git rev-parse --git-dir 2>/dev/null)
        if test -n "$git_info"
            set -l branch (command git symbolic-ref --short HEAD 2>/dev/null; or command git rev-parse --short HEAD 2>/dev/null)
            set -l dirty ""

            if not command git diff --quiet --ignore-submodules HEAD 2>/dev/null
                set dirty "*"
            end

            printf '%s %s%s%s ' $violet $branch $dirty $normal
        end
    end

    printf '%s⟩%s ' $violet $normal
end

function fish_right_prompt
    set -l violet (set_color -o D291BC)
    set -l normal (set_color normal)
    printf '%s%s' $violet (date "+%H:%M:%S")
end

function __safe_git
    if type -q git
        git $argv
    else
        printf "git not installed\n"
        return 127
    end
end
