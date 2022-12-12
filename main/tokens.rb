require "walk_up"
require_relative walk_up_until("paths.rb")
require_relative PathFor[:textmate_tools]

# 
# Create tokens
#
# (these are from C++)
tokens = [
    { representation: '|' , areInvalidLiterals: true },
    { representation: '&' , areInvalidLiterals: true },
    { representation: ';' , areInvalidLiterals: true },
    { representation: '<' , areInvalidLiterals: true },
    { representation: '>' , areInvalidLiterals: true },
    { representation: '(' , areInvalidLiterals: true },
    { representation: ')' , areInvalidLiterals: true },
    { representation: '$' , areInvalidLiterals: true },
    { representation: '`' , areInvalidLiterals: true },
    { representation: '\\', areInvalidLiterals: true },
    { representation: '"' , areInvalidLiterals: true },
    { representation: '\'', areInvalidLiterals: true },
    { representation: "case"     , areShellReservedWords: true, },
    { representation: "coproc"   , areShellReservedWords: true, },
    { representation: "do"       , areShellReservedWords: true, },
    { representation: "done"     , areShellReservedWords: true, },
    { representation: "elif"     , areShellReservedWords: true, },
    { representation: "else"     , areShellReservedWords: true, },
    { representation: "end"      , areShellReservedWords: true, }, # https://info2html.sourceforge.net/cgi-bin/info2html-demo/info2html?(zsh)Reserved%2520Words
    { representation: "esac"     , areShellReservedWords: true, },
    { representation: "export"   , areShellReservedWords: true, },
    { representation: "fi"       , areShellReservedWords: true, },
    { representation: "for"      , areShellReservedWords: true, },
    { representation: "foreach"  , areShellReservedWords: true, },
    { representation: "function" , areShellReservedWords: true, },
    { representation: "if"       , areShellReservedWords: true, },
    { representation: "in"       , areShellReservedWords: true, },
    { representation: "local"    , areShellReservedWords: true, },
    { representation: "logout"   , areShellReservedWords: true, },
    { representation: "popd"     , areShellReservedWords: true, },
    { representation: "nocorrect", areShellReservedWords: true, },
    { representation: "pushd"    , areShellReservedWords: true, },
    { representation: "pwd"      , areShellReservedWords: true, },
    { representation: "readonly" , areShellReservedWords: true, },
    { representation: "repeat"   , areShellReservedWords: true, },
    { representation: "select"   , areShellReservedWords: true, },
    { representation: "then"     , areShellReservedWords: true, },
    { representation: "time"     , areShellReservedWords: true, },
    { representation: "until"    , areShellReservedWords: true, },
    { representation: "while"    , areShellReservedWords: true, },
    { representation: "."          , areBuiltInCommands: true },
    { representation: ":"          , areBuiltInCommands: true },
    { representation: "alias"      , areBuiltInCommands: true },
    { representation: "autoload"   , areBuiltInCommands: true },
    { representation: "bg"         , areBuiltInCommands: true },
    { representation: "bindkey"    , areBuiltInCommands: true },
    { representation: "break"      , areBuiltInCommands: true },
    { representation: "builtin"    , areBuiltInCommands: true },
    { representation: "cd"         , areBuiltInCommands: true },
    { representation: "command"    , areBuiltInCommands: true },
    { representation: "declare"    , areBuiltInCommands: true },
    { representation: "dirs"       , areBuiltInCommands: true },
    { representation: "disown"     , areBuiltInCommands: true },
    { representation: "echo"       , areBuiltInCommands: true },
    { representation: "eval"       , areBuiltInCommands: true },
    { representation: "exec"       , areBuiltInCommands: true },
    { representation: "exit"       , areBuiltInCommands: true },
    { representation: "false"      , areBuiltInCommands: true },
    { representation: "fc"         , areBuiltInCommands: true },
    { representation: "fg"         , areBuiltInCommands: true },
    { representation: "getopts"    , areBuiltInCommands: true },
    { representation: "hash"       , areBuiltInCommands: true },
    { representation: "history"    , areBuiltInCommands: true },
    { representation: "jobs"       , areBuiltInCommands: true },
    { representation: "kill"       , areBuiltInCommands: true },
    { representation: "let"        , areBuiltInCommands: true },
    { representation: "print"      , areBuiltInCommands: true },
    { representation: "read"       , areBuiltInCommands: true },
    { representation: "return"     , areBuiltInCommands: true },
    { representation: "set"        , areBuiltInCommands: true },
    { representation: "shift"      , areBuiltInCommands: true },
    { representation: "source"     , areBuiltInCommands: true },
    { representation: "stat"       , areBuiltInCommands: true },
    { representation: "suspend"    , areBuiltInCommands: true },
    { representation: "test"       , areBuiltInCommands: true },
    { representation: "times"      , areBuiltInCommands: true },
    { representation: "trap"       , areBuiltInCommands: true },
    { representation: "true"       , areBuiltInCommands: true },
    { representation: "type"       , areBuiltInCommands: true },
    { representation: "typeset"    , areBuiltInCommands: true },
    { representation: "ulimit"     , areBuiltInCommands: true },
    { representation: "umask"      , areBuiltInCommands: true },
    { representation: "umask"      , areBuiltInCommands: true },
    { representation: "unalias"    , areBuiltInCommands: true },
    { representation: "unfunction" , areBuiltInCommands: true },
    { representation: "unhash"     , areBuiltInCommands: true },
    { representation: "unlimit"    , areBuiltInCommands: true },
    { representation: "unset"      , areBuiltInCommands: true },
    { representation: "unsetopt"   , areBuiltInCommands: true },
    { representation: "wait"       , areBuiltInCommands: true },
    { representation: "which"      , areBuiltInCommands: true },
]

# automatically add some adjectives (functional adjectives)
@tokens = TokenHelper.new tokens, for_each_token: ->(each) do 
    # isSymbol, isWordish
    if each[:representation] =~ /[a-zA-Z0-9_]/
        each[:isWordish] = true
    else
        each[:isSymbol] = true
    end
    # isWord
    if each[:representation] =~ /\A[a-zA-Z_][a-zA-Z0-9_]*\z/
        each[:isWord] = true
    end
end