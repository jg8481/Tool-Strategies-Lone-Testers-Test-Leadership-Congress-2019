# Test tool strategies for lone testers - Test Leadership Congress 2019 Presentation

## General Information

This repo contains all of the examples that will be covered in the "Test tool strategies for lone testers" presentation. More information about this Test Leadership Congress 2019 presentation can be found here... https://testleadershipcongress2019.sched.com/event/O5Zg/test-tool-strategies-for-lone-testers

The following are the basic technical requirements to run the examples during the presentation.
- Docker CE
  - OSX: https://docs.docker.com/docker-for-mac/install
  - Windows: https://docs.docker.com/docker-for-windows/install
  - Ubuntu: https://docs.docker.com/install/linux/docker-ce/ubuntu

- Docker Compose
  - OSX: Included in Docker CE
  - Windows: Included in Docker CE
  - Ubuntu: https://docs.docker.com/compose/install/#install-compose

The following are optional requirements that you can install on your machine. They will be explained in the presentation and demonstrations.

- cURL -> https://curl.haxx.se
- yEd Graph Editor -> https://www.yworks.com/products/yed
- a Slack account (preferably one under your control)
- RobotFramework-Metrics -> https://github.com/adiralashiva8/robotframework-metrics
- Charles Proxy -> https://www.charlesproxy.com/documentation/proxying
- Appium Desktop -> https://github.com/appium/appium-desktop

Here is a brief summary of some of the tools used in this presentation.

- Dockerized parallel and serial randomized tests, with results merging using Robot Framework.
- Options for generating randomized test data using builtin keywords or malformed test data with the well known Radamsa general purpose fuzzing tool, https://gitlab.com/akihe/radamsa
- Several examples of Slack notification keywords using a hybrid-manual-automated approach and Dockerized tests
- Robot Framework + Graphwalker (a model-based testing tool) examples with replayable test runs while running a slow internet connection proxy called "Crapify", https://github.com/bcoe/crapify
- Webhook mechanism that can trigger remote test processes with cURL commands, https://github.com/adnanh/webhook
- Dashboard of Session-based Test Management using Shiva Prasad Adirala's excellent RobotFramework-Metrics project, https://github.com/adiralashiva8/robotframework-metrics

The examples in the presentation use a lot of Shell scripting. If you have a Windows operating system, the following options may work for you.
- Consider downloading Git for Windows -> https://git-scm.com/download/win and https://gitforwindows.org
- Windows 10 users may already have Bash -> http://techgenix.com/bash-on-windows-10
- Since you will probably already have docker-compose installed you can copy the commands and run them individually.

Before the presentation, please run the following on your machine.
```
git clone https://github.com/jg8481/Tool-Strategies-Lone-Testers-Test-Leadership-Congress-2019.git
cd ./Tool-Strategies-Lone-Testers-Test-Leadership-Congress-2019
```
Set up `.env` and `local.env` files using the provided `template.env` and `template.local.env` files. After setting up your `.env` and `local.env` files you can run the following, but it will require Docker on your machine.
```
./start-specific-docker-example-workflows-for-workshop.sh Build-Images-Teardown-Old-Docker-Containers
```

## Presentation Examples

There will be presentation slides explaining the following in more detail and I will assist everyone with running them.

1. Part One - Tool strategy examples for rapidly testing and adapting to frequently changing projects
```
./start-specific-docker-example-workflows-for-workshop.sh Part-One-Postman-Newman-Workshop-Examples
./start-specific-docker-example-workflows-for-workshop.sh Part-One-cURL-Workshop-Examples
./start-specific-docker-example-workflows-for-workshop.sh Part-One-Requests-Library-Workshop-Examples
./start-specific-docker-example-workflows-for-workshop.sh Part-One-Python-Library-Workshop-Examples
./start-specific-docker-example-workflows-for-workshop.sh Part-One-Run-All-Docker-Workshop-Examples
```

2. Part Two - Tool strategy examples for enhancing existing tests and taking your test process further
```
./start-specific-docker-example-workflows-for-workshop.sh Part-Two-Postman-Newman-Workshop-Examples
./start-specific-docker-example-workflows-for-workshop.sh Part-Two-Python-Library-Workshop-Examples
./start-specific-docker-example-workflows-for-workshop.sh Part-Two-Requests-Library-Workshop-Examples
./start-specific-docker-example-workflows-for-workshop.sh Part-Two-cURL-Workshop-Examples
./start-specific-docker-example-workflows-for-workshop.sh Remote-Test-Process-Triggered-By-A-Webhook-Docker-Example
./start-specific-docker-example-workflows-for-workshop.sh Long-Graphwalker-Run-Workshop-Example
./start-specific-docker-example-workflows-for-workshop.sh Short-Graphwalker-Run-Workshop-Example
./start-specific-docker-example-workflows-for-workshop.sh Previous-Long-Graphwalker-Run-Workshop-Example
./start-specific-docker-example-workflows-for-workshop.sh Previous-Short-Graphwalker-Run-Workshop-Example
./start-specific-local-machine-example-workflows-for-workshop.sh Hybrid-Tool-Desktop-Workshop-Example
./start-specific-local-machine-example-workflows-for-workshop.sh Hybrid-Tool-Desktop-Charles-Proxy-Workshop-Example
```

3. Part Three - Combined results visualizing your testing story
```
./start-specific-result-gathering-example-workflows-for-workshop.sh Combined-Results-Dashboard-Workshop-Example
./start-specific-result-gathering-example-workflows-for-workshop.sh Metrics-Dashboard-Workshop-Example
```

Part Three of the presentations covers the following dashboards.
- https://robocon2019-workshop-dashboard.herokuapp.com/
- https://robocon2019-sbtm-dashboard.herokuapp.com/
- https://joshua-gorospe-qa-dashboard2.herokuapp.com/

The following additional examples are for future webinars and workshops. Some of these examples require Appium, iOS Simulators, and Android Emulators to be installed.

US Robot Framework Community Webinars - August 22, 2019 - Commands used to run the examples for this webinar.
```
./start-specific-docker-example-workflows-for-workshop.sh Remote-Selenium-Process-Triggered-By-A-Webhook-Docker-Example
./start-specific-local-machine-example-workflows-for-workshop.sh Robot-Framework-Desktop-Web-Test-Example
./start-specific-local-machine-example-workflows-for-workshop.sh Appium-Web-Browser-Setup
./start-specific-local-machine-example-workflows-for-workshop.sh Appium-Web-Browser-Teardown
./start-specific-local-machine-example-workflows-for-workshop.sh Robot-Framework-Mobile-Web-Test-Example
```

Use the following information to help set up the basic Appium requirements:
- https://appiumpro.com/editions/4
- http://testnblog.com/appium-up-running-with-robot-framework/
- http://testnblog.com/how-to-setup-android-virtual-devicesavdemulatorfor-android-test-automation/
- http://testnblog.com/ios-automation-with-appium-1-6-robot-framework/
- https://blog.kmkonline.co.id/setting-appium-with-multiple-ios-devices-444fe7f234e1
- https://www.linkedin.com/pulse/iphone-automation-using-robot-framework-cerosh-jacob?trk=related_artice_iPhone%20automation%20using%20Robot%20Framework_article-card_title
- https://robotframework.org/

After installing Appium try running ``appium-doctor``. If any warnings show up please follow the instructions.

***

Slides for the presentation and additional videos of content that was not covered in the Test Leadership Congress 2019 conference recordings can be found in this repo.
- [Test_Tool_Strategies_For_Lone_Testers.pdf](https://github.com/jg8481/Tool-Strategies-Lone-Testers-Test-Leadership-Congress-2019/blob/master/Workshop-Presentations-And-Videos/Test_Tool_Strategies_For_Lone_Testers.pdf)
- [Demonstration_Of_Appium_Desktop_Code_Generator_Robot_Framework_Example.mp4](https://github.com/jg8481/Tool-Strategies-Lone-Testers-Test-Leadership-Congress-2019/blob/master/Workshop-Presentations-And-Videos/Demonstration_Of_Appium_Desktop_Code_Generator_Robot_Framework_Example.mp4)
- [Demonstration_Of_Charles_Proxy_With_Appium_Desktop_SBTM_Robot_Framework.mp4](https://github.com/jg8481/Tool-Strategies-Lone-Testers-Test-Leadership-Congress-2019/blob/master/Workshop-Presentations-And-Videos/Demonstration_Of_Charles_Proxy_With_Appium_Desktop_SBTM_Robot_Framework.mp4)

This presentation is based on a workshop that was done at RoboCon 2019 in Finland. More information can be found in the following.
- https://robocon.io/#workshops
- https://github.com/jg8481/Robot-Framework-Lone-Tester-Strategies-RoboCon-2019

I also wrote an article on Medium describing the gist of the hybrid-manual-automated approach covered in the presentation.
- https://ixn.intersection.com/how-machine-learning-can-assist-testers-f42ce28e4792

Additional slides for future presentations and webinars that used the tool examples in this Test Leadership Congress 2019 repo as a template.
- [US Robot Framework Community Webinars - August 22, 2019 - Test_Tool_Strategies_For_Lone_Testers.pdf](https://github.com/jg8481/Tool-Strategies-Lone-Testers-Test-Leadership-Congress-2019/blob/master/Workshop-Presentations-And-Videos/Tool_Strategies_For_Mobile_And_Desktop_Browsers.pdf)

***

## Big thank you to the following people and groups.

- Pekka Klarck
- Ed Manlove
- Antti Karjalainen
- James Bach
- Jonathon Bach
- Michael Bolton
- Cem Kaner
- Anders Dinsen
- Anna Royzman
- Kristian Karl
- Mikko Korpela
- Bryan Oakley
- Shiva Prasad Adirala
- Tatu Aalto
- The Docker development team
- The Graphwalker development team
- The entire Robot Framework community and its contributors

Their contributions to the testing community helped me a lot with this presentation and my day-to-day work.
