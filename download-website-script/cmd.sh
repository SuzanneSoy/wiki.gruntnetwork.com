mv localhost "localhost_$(date)"

(cd ../zimmer; npm install)

../zimmer/wikizimmer.js http://localhost/mediawiki/index.php/Accueil \
  --pages 'Accueil|Affichage_Graphique|Conventions|Drivers/mode_reel.h:int86|Environnement_de_programmation|GRUB|Langage|Liens|Notes|Nouveau_Développeur|Prérequis|Test_fonctionC|Toutes_les_pages' \
  --content body \
  --remove 'script:not(#random-script),a[href*="action=edit"],.editsection,.mw-editsection,#privacy,#about,#disclaimer,#p-personal,#p-cactions-mobile,#p-cactions,#column-one h2,#p-personal-toggle,#globalWrapper-toggle,#p-search,#t-whatlinkshere,#t-recentchangeslinked,#t-permalink,#t-info,#n-recentchanges' $(: ',#t-specialpages') \
  --template template.html \
  --style stub.css \
  --no-default-style \
  --verbose \

sed -i -e 's|./../data:image/svg+xml|data:image/svg+xml|g' localhost/-/zim.css

cp localhost/Accueil.html localhost/index.html

cid="$(ipfs cid base32 "$(ipfs add --recursive --progress --hidden --quieter --pin=false localhost)" | sed -e 's|^|https://|;s|$|.ipfs.dweb.link|')"

(printf %s "$cid" | wl-copy) || true

printf \\n%s\\n "$cid"
