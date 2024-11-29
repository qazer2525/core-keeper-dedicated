#!/bin/bash
mkdir -p "${STEAMAPPDIR}" || true

# Initialize arguments array
args=(
    "+force_install_dir" "$STEAMAPPDIR"
    "+login" "anonymous"
    "+app_update" "$STEAMAPPID" "validate"
    "+app_update" "$STEAMAPPID_TOOL" "validate"
)

# Override SteamCMD launch arguments if necessary
# Used for subscribing to betas or for testing
if [ -n "$STEAMCMD_UPDATE_ARGS" ]; then
    args+=("${STEAMCMD_UPDATE_ARGS[@]}")
fi

# Add the quit command
args+=("+quit")

# Run SteamCMD with the arguments
bash "${STEAMCMDDIR}/steamcmd.sh" "${args[@]}"

# add custom dll
mv "${CUSTOMPUG}" "${STEAMAPPDIR}/CoreKeeperServer_Data/Managed/Pug.Other.dll"

exec bash "${SCRIPTSDIR}/launch.sh"