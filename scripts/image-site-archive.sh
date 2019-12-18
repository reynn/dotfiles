#!/usr/bin/env zsh

source $DFP/.zshrc.min

export YIFF_CREATORS=(
  "nagisa|https://yiff.party/fantia/17148"
  "eri_kitami|https://yiff.party/fantia/4170"
  "elliemarie|https://yiff.party/patreon/5283562"
  "jinxkittie_cosplay|https://yiff.party/patreon/2815752"
  "darshellestevens|https://yiff.party/patreon/514000"
  "ahriuwu|https://yiff.party/patreon/4372872"
  "arisa|https://yiff.party/patreon/154251"
  "chono|https://yiff.party/patreon/4359251"
  "danisaurz|https://yiff.party/patreon/403234"
  "elleslove|https://yiff.party/patreon/20259648"
  "emiliabears|https://yiff.party/patreon/12687964"
  "feliciavox|https://yiff.party/patreon/4173771"
  "hidori_rose|https://yiff.party/patreon/6311207"
  "iamdorasnow|https://yiff.party/patreon/4428702"
  "jeanwanwan|https://yiff.party/patreon/3654434"
  "kayyybear|https://yiff.party/patreon/2670301"
  "kiyocosplay|https://yiff.party/patreon/3253308"
  "kuuko_w|https://yiff.party/patreon/6889522"
  "megumi_koneko|https://yiff.party/patreon/4255482"
  "merylsama|https://yiff.party/patreon/2818822"
  "mikomihokina|https://yiff.party/patreon/2592616"
  "mikomin|https://yiff.party/patreon/10773132"
  "mimi_malice|https://yiff.party/patreon/4841834"
  "misswarmj|https://yiff.party/patreon/5489259"
  "nyaomaruu|https://yiff.party/patreon/5333784"
  "pattie_cosplay|https://yiff.party/patreon/9146144"
  "peach_jars|https://yiff.party/patreon/18468403"
  "peach_milky|https://yiff.party/patreon/675821"
  "pialoof|https://yiff.party/patreon/5351089"
  "pixiecat|https://yiff.party/patreon/14107762"
  "potatogodzilla|https://yiff.party/patreon/14158508"
  "princess_helayna|https://yiff.party/patreon/17392092"
  "rocksylight|https://yiff.party/patreon/4455880"
  "saorikiyomi|https://yiff.party/patreon/3501933"
  "stellachuu|https://yiff.party/patreon/2622397"
  "tsikyo|https://yiff.party/patreon/2758808"
  "virtualgeisha|https://yiff.party/patreon/4735602"
  "vivid_vision|https://yiff.party/patreon/5183065"
  "yoonie|https://yiff.party/patreon/767316"
  "yuzupyon|https://yiff.party/patreon/6012648"
  "zettairyouiki_runa|https://yiff.party/patreon/17345777"
)

export LINKS=()
export CREATORS=()

# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------

for c in $YIFF_CREATORS; do
  local name_split=($(helpers text split -d '|' "$c"))

  CREATORS+=(${name_split[1]})
  LINKS+=(${name_split[2]})
done

print_repeated '-' 80
echo "$CREATORS"
print_repeated '-' 80
echo "$LINKS"
