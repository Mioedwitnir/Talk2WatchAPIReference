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

import bb.cascades 1.2
import bb.system 1.2

TabbedPane {
    id: mainPane

    Tab {
        title: "Description"
        Page {	// descriptionPage
            ScrollView {	// scrollView
                Container {	// scrollViewContainer
                    leftPadding: 30
                    rightPadding: 30
                    Label {
                        verticalAlignment: VerticalAlignment.Center
                        text: "Description"
                        textStyle.base: SystemDefaults.TextStyles.BigText
                    }        
                    
                    TextArea {
                        editable: false
                        text: "This app is the reference implementation of the Talk2Watch API and can be seen as a programming example for developers. It is meant to demonstrate the possibilities of interprocess communication with the Talk2Watch app."
                    }


					Button {
					    text: "Source Code"
			        	onClicked: {
                            t2w.forwardSourceCode()
                            }
         			}
                                        
                    Container {
                        layout: StackLayout {orientation: LayoutOrientation.LeftToRight}   
                        Label {
                            horizontalAlignment: HorizontalAlignment.Left
                            verticalAlignment: VerticalAlignment.Center
                            text: "App integration"
                            textStyle.base: SystemDefaults.TextStyles.TitleText
                        }
                        Button {
                            horizontalAlignment: HorizontalAlignment.Right
                            verticalAlignment: VerticalAlignment.Center
                            text: "Details"
                            
                            onClicked: {
                                mainPane.activeTab = appIntegrationTab
                            }
                        }
                    }
                    TextArea {
                        editable: false
                        text: "A step-by-step authentication and action creation example"
                    }
                    
                }	// scrollViewContainer
            }	// scrollView
        }	// descriptionPage
    }
   
    Tab {
        id: appIntegrationTab
        title: "App integration"
        Page {	// page
            ScrollView {
                Container {	// mainPageContainer
                    leftPadding: 30
                    rightPadding: 30
                    Label {
                        verticalAlignment: VerticalAlignment.Center
                        text: "App integration"
                        textStyle.base: SystemDefaults.TextStyles.BigText
                    }
                    
                    Label {
                        text: "Step 1: Authentication"
                        textStyle.base: SystemDefaults.TextStyles.TitleText
                    }
                    Container {
                        topPadding: 10
                        layout: StackLayout {orientation: LayoutOrientation.LeftToRight}         
                        Label {
                            verticalAlignment: VerticalAlignment.Center
                            text: "App title"
                            preferredWidth: 250
                        }
                        TextField {
                            verticalAlignment: VerticalAlignment.Center
                            id: appTitleField
                            text: "NewApp"
                        }     
                    }   
                    TextArea {
                        editable: false
                        topPadding: 10
                        text: "The title should be a unique identifier for the app."
                    }
                    Container {
                        topPadding: 10
                        layout: StackLayout {orientation: LayoutOrientation.LeftToRight}         
                        Label {
                            verticalAlignment: VerticalAlignment.Center
                            text: "App version"
                            preferredWidth: 250
                        }
                        TextField {
                            verticalAlignment: VerticalAlignment.Center
                            id: appVersionField
                            text: "1.0"
                        }     
                    }         
                    TextArea {
                        editable: false
                        topPadding: 10
                        text: "A version number for the app integration part. It is used as an indicator to find out which actions have already been created."
                    }
                    Container {
                        topPadding: 10
                        layout: StackLayout {orientation: LayoutOrientation.LeftToRight}         
                        Label {
                            verticalAlignment: VerticalAlignment.Center
                            text: "App key"
                            preferredWidth: 250
                        }
                        TextField {
                            verticalAlignment: VerticalAlignment.Center
                            id: appKeyField
                            text: "df78962534Sad2378ewasd"
                        }     
                    }       
                    TextArea {
                        editable: false
                        topPadding: 10
                        text: "A unique sequence to protect your app against modifications from others. Ensure that you always you the same key for your app!"
                    }
                    Container {
                        topPadding: 10
                        layout: StackLayout {orientation: LayoutOrientation.LeftToRight}         
                        Label {
                            verticalAlignment: VerticalAlignment.Center
                            text: "App description"
                            preferredWidth: 250
                        }
                        TextArea {
                            verticalAlignment: VerticalAlignment.Center
                            id: appDescriptionTextArea
                            text: "This is a new app"
                        }
                    }     
                    TextArea {
                        editable: false
                        topPadding: 10
                        text: "The 'Description' will only be displayed on the Script page and should give some more information about the app. Also a link to the app in BB world can be added here."
                    }
                    Container {
                        topPadding: 10
                        layout: StackLayout {orientation: LayoutOrientation.LeftToRight}         
                        Label {
                            verticalAlignment: VerticalAlignment.Center
                            text: "Auth status"
                            preferredWidth: 250
                        }
                        Label {
                            verticalAlignment: VerticalAlignment.Center
                            objectName: "m_authStatusLabel"
                            text: "AUTH_UNKNOWN"
                            
                            onTextChanged: {
                                if(text=="AUTH_SUCCESS")
                                    scriptCreationContainer.setVisible(true)
                                else if(text=="AUTH_KEY_MISMATCH")
                                    scriptCreationContainer.setVisible(false)
                            }
                        }    
                    }                    
                    Button {
                        verticalAlignment: VerticalAlignment.Center
                        horizontalAlignment: HorizontalAlignment.Center
                        text: "Request AUTH"
                        onClicked: {
                            t2w.setAppValues(appTitleField.text, appVersionField.text, appKeyField.text, "UDP", "8484", appDescriptionTextArea.text);
                            t2w.sendAppAuthorizationRequest();
                        }
                    }
                    
                    
                    Container {
                        topPadding: 50
                        //visible: false
                        id: scriptCreationContainer
                        
                        Label {
                            text: "Step 2: Action creation"
                            textStyle.base: SystemDefaults.TextStyles.TitleText
                        }
                        
                        Container {
                            layout: StackLayout {orientation: LayoutOrientation.LeftToRight}         
                            Label {
                                verticalAlignment: VerticalAlignment.Center
                                text: "Title"
                                preferredWidth: 250
                            }
                            TextField {
                                verticalAlignment: VerticalAlignment.Center
                                id: scriptTitleTextField
                                text: "NewAction"
                            }     
                        }   
                        TextArea {
                            editable: false
                            topPadding: 10
                            text: "The 'Title' will be displayed in the action list when the user uses ScriptMode."
                        }
                        Container {
                            topPadding: 10
                            layout: StackLayout {orientation: LayoutOrientation.LeftToRight}         
                            Label {
                                verticalAlignment: VerticalAlignment.Center
                                text: "Command"
                                preferredWidth: 250
                            }
                            TextField {
                                verticalAlignment: VerticalAlignment.Center
                                id: scriptCommandTextField
                                text: "NewCommand"
                            }     
                        }   
                        TextArea {
                            editable: false
                            topPadding: 10
                            text: "The 'Command' is the value which will be sent to back to this app when the user triggers the action."
                        }
                        Container {
                            topPadding: 10
                            layout: StackLayout {orientation: LayoutOrientation.LeftToRight}         
                            Label {
                                verticalAlignment: VerticalAlignment.Center
                                text: "Description"
                                preferredWidth: 250
                            }
                            TextArea {
                                verticalAlignment: VerticalAlignment.Center
                                id: actionDescriptionTextArea
                                text: "This is a new action"
                            }
                        }  
                        TextArea {
                            editable: false
                            topPadding: 10
                            text: "The 'Description' will only be displayed on the Script page and should give some more information about the action."
                        }
                        Button {
                            verticalAlignment: VerticalAlignment.Center
                            horizontalAlignment: HorizontalAlignment.Center
                            text: "Create action"
                            onClicked: {
                                t2w.createAction(scriptTitleTextField.text, scriptCommandTextField.text, actionDescriptionTextArea.text);
                            }
                        }                    
                    }
                    
                    
                    Container {
                        topPadding: 50
                        visible: false
                        id: scriptVerificationContainer
                        
                        Label {
                            text: "Step 3: Verification (optional)"
                            textStyle.base: SystemDefaults.TextStyles.TitleText
                        }
                    }
                    
                    bottomPadding: 50
                }    //mainPageContainer
            }
        }	// page
    }
    Tab {
        title: "Sending Messages"
        Page {	// page
          ScrollView {
              Container {	// mainPageContainer
                  leftPadding: 30
                  rightPadding: 30
                  Label {
                      objectName: "m_label"
                      text: "Sending Messages"
                      textStyle.base: SystemDefaults.TextStyles.BigText
                      verticalAlignment: VerticalAlignment.Center
                  }
                  Container {
                      topPadding: 10
                      layout: StackLayout {orientation: LayoutOrientation.LeftToRight}         
                      Label {
                          text: "Title"
                          preferredWidth: 250
                          verticalAlignment: VerticalAlignment.Center
                      }
                      
                      TextField {
                          id: messageTitleField
                          verticalAlignment: VerticalAlignment.Center
                          text: "Hello"
                      }
                  
                  }
                  Container {
                      topPadding: 10
                      layout: StackLayout {orientation: LayoutOrientation.LeftToRight}         
                      Label {
                          text: "Text"
                          preferredWidth: 250
                          verticalAlignment: VerticalAlignment.Center
                      }
                      
                      TextField {
                          id: messageTextField
                          verticalAlignment: VerticalAlignment.Center
                          text: "Hello"
                      }
                  
                  }
                  
                  Button {
                      horizontalAlignment: HorizontalAlignment.Center
                      text: "Send"
                      verticalAlignment: VerticalAlignment.Center
                      onClicked: {
                          t2w.sendSms(messageTitleField.text, messageTextField.text)
                      }
                  }
                  bottomPadding: 50
              
              }    //mainPageContainer
          }
        }	// page

    }	// Tab
}