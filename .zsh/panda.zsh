## xp_runner
# pretty print xp_runner output
xpjq() {
  xp_runner job config $1 2>/dev/null | jq $2
}


## matrix
# open tunnel to matrix
neobook() {
        ssh -NL 8890:localhost:8890 neo
}
neobook-out() {
        ssh -NL 8890:localhost:8890 neo-out
}

## datasets
mkdataset() {
  DSETNAME="$1"
  CLASSESJSON="$2"
  STOP=false
  if ! [[ -n ${DSETNAME} ]]; then
    echo "Define new dataset name"
    STOP=true
  fi
  if ! [[ -n ${CLASSESJSON} ]]; then
    echo "Define classes.json path"
    STOP=true
  fi
  if eval $STOP; then
    return
  fi
  N_CLASSES=$(expr $(jq '. | length' "${CLASSESJSON}") - 1)
  eval "mkdir -p "${DSETNAME}"/{train,test}/inputs/{0..${N_CLASSES}}"
  cp ${CLASSESJSON} ${DSETNAME}/train
  cp ${CLASSESJSON} ${DSETNAME}/test
}

## models
deploy_model() {
  MODEL_PATH=/datanet/./${PWD#/Users/sven/Pandascore/bordel/datanet/}
  echo 'dev'
  rsync -aR --info=progress2 --ignore-existing $1 dev-datanet:$MODEL_PATH
  echo 'prod'
  rsync -aR --info=progress2 --ignore-existing $1 datanet:$MODEL_PATH
}

## kubernetes
source ~/Pandascore/tools/env_gcloud
alias k='kubectl'
alias kl='kubectl logs -f'
alias kme='watch -t -c -n .3 "kubectl get pods -o wide -l \"chart in (market-engine-deployer-0.0.1,market-engine-live-0.0.1,prematch-market-engine-0.0.1,poe-0.0.1)\" | kcolors";'
kks() { kubectl scale --replicas=0 --all deploy $1 && kubectl scale --replicas=1 --all deploy $1 }
kpw() { watch -t -c -n .3 "kubectl get pod -o wide | grep "$1-" | kcolors" }
function kubectl() {
  if ! type __start_kubectl >/dev/null 2>&1; then
    source <(command kubectl completion zsh)
  fi
  command kubectl "$@"
}


## postgres
pg() {
  input=$1
  case ${input} in
    "dev")
        PGPASSWORD=$PANDASCORE_POSTGRES_DEV_PASS pgcli -h localhost -U $PANDASCORE_POSTGRES_DEV_USER -p $PANDASCORE_POSTGRES_DEV_PORT -d $PANDASCORE_POSTGRES_DEV_DB_NAME
        ;;
    "prod")
        PGPASSWORD=$PANDASCORE_POSTGRES_PROD_PASS pgcli -h localhost -U $PANDASCORE_POSTGRES_PROD_USER -p $PANDASCORE_POSTGRES_PROD_PORT -d $PANDASCORE_POSTGRES_PROD_DB_NAME
        ;;
    *)
        echo "Usage :"
        echo "pg [dev|prod]"
        ;;
    esac
}

## pce trigger
trigger_pce () {
    if [ -z $1 ]; then
        echo '$1 not set (branch)';
    elif [ -z $2 ]; then
        echo '$2 not set (leagues)';
    else
        curl -v --request POST --form token=$PANDASCORE_GITLAB_TOKEN --form ref=$1 --form "variables[RUN_TRIGGER_PRECOMPUTE]=1" --form "variables[WHITELISTED_LEAGUE_IDS]=$2" "https://git.pandascore.co/api/v4/projects/150/trigger/pipeline";
    fi;
}

## panda utils (penv/pwake/psleep)
source /Users/sven/.panda-utils/scripts/source.sh

## monocle/ramen autocompletion
autoload -U bashcompinit
bashcompinit
eval "$(register-python-argcomplete monocle)"
eval "$(register-python-argcomplete ramen)"

## pandavision debug level
export VISION_DEBUG_LEVEL='200'

## google
# The next line updates PATH for the Google Cloud SDK.
if [ -f '$HOME/Pandascore/google-cloud-sdk/path.zsh.inc' ]; then source '$HOME/Pandascore/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '$HOME/Pandascore/google-cloud-sdk/completion.zsh.inc' ]; then source '#HOME/Pandascore/google-cloud-sdk/completion.zsh.inc'; fi

