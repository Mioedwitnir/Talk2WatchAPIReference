/*
 * Copyright (c) 2011-2013 BlackBerry Limited.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include "applicationui.hpp"

#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include "Talk2WatchInterface.h"
#include "UdpModule.h"
#include <bb/system/SystemToast>

using namespace bb::cascades;

ApplicationUI::ApplicationUI(bb::cascades::Application *app) :
        QObject(app)
{

    t2w = new Talk2WatchInterface(this);


    // Create scene document from main.qml asset, the parent is set
    // to ensure the document gets destroyed properly at shut down.
    QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);
    qml->setContextProperty("t2w", t2w);


    // Create root object for the UI
    AbstractPane *root = qml->createRootObject<AbstractPane>();

    // Set created root object as the application scene
    app->setScene(root);

    m_authStatusLabel = root->findChild<Label*>("m_authStatusLabel");

    connect(t2w, SIGNAL(receivedData(QString)), this, SLOT(onUdpDataReceived(QString)));
    connect(t2w, SIGNAL(transmissionReady()), this, SLOT(onTransmissionReady()));

}


void ApplicationUI::onTransmissionReady()
{
	qDebug() << "onTransmissionReady";
}

void ApplicationUI::onUdpDataReceived(QString _data)
{
	qDebug() << "onUdpDataReceived";
	bb::system::SystemToast *toast = new bb::system::SystemToast(this);
	toast->setBody(_data);
	toast->show();

	if(_data=="AUTH_SUCCESS" || _data=="AUTH_KEY_MISMATCH")
		m_authStatusLabel->setText(_data);
}
