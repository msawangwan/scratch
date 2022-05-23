#!/usr/bin/env bash -e

# promote a docker image across medistrano projects and environments

main() {
	local project_from="$1"
	local project_to="$2"
	local build_id="$3"

	if [[ -z $project_from || -z $project_to || -z $build_id ]]; then
		echo "missing arguments: ./$(basename $0) \$PROJECT_FROM \$PROJECT_TO \$BUILD_ID"
	fi

	aws ecr get-login-password \
		--region us-east-1 |
		docker login \
			--username AWS \
			--password-stdin \
			565378680304.dkr.ecr.us-east-1.amazonaws.com

	docker build . -t 565378680304.dkr.ecr.us-east-1.amazonaws.com/mdsol/$project_to/build:$build_id -f - <<-EOF
		FROM 565378680304.dkr.ecr.us-east-1.amazonaws.com/mdsol/$project_from/build:$build_id
		LABEL com.mdsol.12f-app $project_to
	EOF

	docker push 565378680304.dkr.ecr.us-east-1.amazonaws.com/mdsol/$project_to/build:$build_id
}

main "$@"
