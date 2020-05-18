
#def prerequisites(ctx):
#def options(opt):
#def configure(conf):
#def build(bld):
_waf_completions()
{
	WORDS=`sed -n 's/def \(.*\)(\(ctx\|conf\|bld\)):$/\1/p' wscript`
	WORDS=`echo $WORDS | tr '\n' ' '`
	COMPREPLY=($(compgen -W "$WORDS" "${COMP_WORDS[1]}"))
}

complete -F _waf_completions waf
