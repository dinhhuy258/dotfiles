#!/bin/zsh

# Get the current aws profile
function agp() {
  echo $AWS_PROFILE
}

# Get the current aws region
function agr() {
  echo $AWS_REGION
}

# AWS profile selection 
function asp() {
  _aws_profiles | __fzfp | {
    read aws_profile;
    if [ ! -z "$aws_profile" ]; then
      export AWS_PROFILE=$aws_profile
    fi
  }
}

# AWS region selection
function asr() {
  local -a available_regions
  available_regions=($(_aws_regions))

  if [ -z "${available_regions[@]}" ]; then
    e_error "You must specify a AWS profile."

    return
  fi

  printf "%s\n" "${available_regions[@]}" | __fzfp | {
    read aws_region;
    if [ ! -z "$aws_region" ]; then
      export AWS_REGION=$aws_region
    fi
  }
}

# Open AWS Console in Firefox browser
function aow() {
  prev_profile=$AWS_PROFILE

  unset AWS_PROFILE

  # Select AWS profile
  asp

  if [[ -z $AWS_PROFILE ]];then
    export AWS_PROFILE=$prev_profile

    return
  fi

  e_arrow "Generating aws login url..."
  login_url=`aws-console --url`
  encoded_url="${login_url//&/%26}"
  if [ -z "${encoded_url}" ]; then
    e_error "AWS token is expired."

    return
  fi
  container_name=$AWS_PROFILE
  firefox "ext+container:name=${container_name}&url=${encoded_url}"

  export AWS_PROFILE=$prev_profile 
}

function _aws_regions() {
  local region
  if [[ $AWS_DEFAULT_REGION ]];then
      region="$AWS_DEFAULT_REGION"
  elif [[ $AWS_REGION ]];then
      region="$AWS_REGION"
  else
      region="us-west-1"
  fi

  if [[ $AWS_DEFAULT_PROFILE || $AWS_PROFILE ]];then
    aws ec2 describe-regions --region $region |grep RegionName | awk -F ':' '{gsub(/"/, "", $2);gsub(/,/, "", $2);gsub(/ /, "", $2);  print $2}'
  fi
}

function _aws_profiles() {
  aws --no-cli-pager configure list-profiles 2> /dev/null && return
  [[ -r "${AWS_CONFIG_FILE:-$HOME/.aws/config}" ]] || return 1
  grep --color=never -Eo '\[.*\]' "${AWS_CONFIG_FILE:-$HOME/.aws/config}" | sed -E 's/^[[:space:]]*\[(profile)?[[:space:]]*([^[:space:]]+)\][[:space:]]*$/\2/g'
}
