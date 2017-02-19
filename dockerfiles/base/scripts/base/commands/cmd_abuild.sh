#!/bin/bash
# Copyright (c) 2012-2016 Codenvy, S.A.
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License v1.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v10.html
#
# Contributors:
#   Tyler Jewell - Initial Implementation
#

pre_cmd_abuild() {
  UTILITY_IMAGE_DEV="eclipse/che-dev"

  if ! is_fast && ! skip_pull; then
    load_utilities_images_if_not_done
    update_image $UTILITY_IMAGE_DEV
  fi
}

cmd_abuild() {
  cd /archetype/$ASSEMBLY_ID
  docker run -it --rm --name build-che \
       -v /var/run/docker.sock:/var/run/docker.sock \
       -v "${M2_MOUNT}"/repository:/home/user/.m2/repository \
       -v "${ARCHETYPE_MOUNT}/${ASSEMBLY_ID}":/home/user/che-build \
       -w /home/user/che-build \
          ${UTILITY_IMAGE_DEV} mvn clean install
}