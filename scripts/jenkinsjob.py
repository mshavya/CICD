import requests

jenkins_job_name = "testing"
Jenkins_url = "http://3.90.4.6:8080"
jenkins_user = "viswa"
jenkins_pwd = "Ilum@1145"
buildWithParameters = False
jenkins_params = {'token': 'jobscreation',
                  'result2':'success',
                  'result1': 'success'}

try:
    auth= (jenkins_user, jenkins_pwd)
    crumb_data= requests.get("{0}/crumbIssuer/api/json".format(Jenkins_url),auth = auth,headers={'content-type': 'application/json'})
    if str(crumb_data.status_code) == "200":

        if buildWithParameters:
            data = requests.get("{0}/job/{1}/buildWithParameters".format(Jenkins_url,jenkins_job_name),auth=auth,params=jenkins_params,headers={'content-type': 'application/json','Jenkins-Crumb':crumb_data.json()['crumb']})
        else:
            data = requests.get("{0}/job/{1}/build".format(Jenkins_url,jenkins_job_name),auth=auth,params=jenkins_params,headers={'content-type': 'application/json','Jenkins-Crumb':crumb_data.json()['crumb']})

        if str(data.status_code) == "201":
            print ("Jenkins job is triggered")
        else:
            print ("Failed to trigger the Jenkins job")

    else:
        print("Couldn't fetch Jenkins-Crumb")
        raise

except Exception as e:
    print ("Failed triggering the Jenkins job")
    print ("Error: " + str(e))