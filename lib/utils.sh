YES=0
NO=1

VERBOSE=$YES
DEBUG=$YES

# ANSI escape codes for colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'  # No Color

err() {
  echo -e "${RED}✗ ERROR: $*${NC}"
}

success() {
  echo -e "${GREEN}✓ $*${NC}"
}

die() {
  err "$*"
  echo "from (${BASH_SOURCE[1]} [${BASH_LINENO[0]}] ${FUNCNAME[1]})"
  kill 0
  exit 99
}

info() {
  [[ $VERBOSE -eq $YES ]] && {
    echo -e "${RED}INFO: ${NC}$*" 1>&2
  }
}

debug() {
  [[ $DEBUG -eq $YES ]] && {
    echo -e "${RED}DEBUG: ${NC}$*" 1>&2
  }
}
