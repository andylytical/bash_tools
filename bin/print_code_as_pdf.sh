#!/usr/bin/bash

. ~/lib/utils.sh

A2PS=/usr/bin/a2ps
PS2PDF=/usr/bin/ps2pdf
TMPFILE=a2ps_output.ps
A2PS_OPTS=( '-2' '-s2' '-o' "${TMPFILE}" )

get_syntax_language() {
  local _fn _ext
  _fn="${1}"
  _ext=$( echo "${_fn}" | awk -F. '{print $NF}' )
  case "${_ext}" in
    py) echo 'python';;
    sh) echo 'bash';;
    *) die "Unknown file ext '${_ext}'"
  esac
}

###
# MAIN
###

[[ -z "${1}" ]] && die "missing filename"
INFILE="${1}"
[[ -r "${INFILE}" ]] || die "cannot read file '${INFILE}'"

lang=$( get_syntax_language "${INFILE}" )
A2PS_OPTS+=( "--pretty-print=${lang}" )

OUTFILE="${INFILE}".pdf

set -x
"${A2PS}" "${A2PS_OPTS[@]}" "${INFILE}"
"${PS2PDF}" "${TMPFILE}" "${OUTFILE}"
