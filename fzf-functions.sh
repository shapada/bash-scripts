function fjxe() { journalctl -xe | fzf }
function fhis() { exec $( history | fzf | awk '{print $2 }' ) }