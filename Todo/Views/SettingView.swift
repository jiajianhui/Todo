//
//  SettingView.swift
//  Todo
//
//  Created by 贾建辉 on 2023/12/19.
//

import SwiftUI
import BetterSafariView

struct SettingView: View {
    
    @State var showSafari = false
    
    //各种sheet
    @State var showDesignSheet = false
    @State var showAboutMeSheet = false
    @State var showPrivacy = false
    
    //与父级的isToggle相绑定
    @Binding var isToggle: Bool
    
    
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    Button {
                        showDesignSheet.toggle()
                    } label: {
                        SettingRowView(imageString: "pencil.and.ruler.fill", linkTitle: "设计初衷")
                    }
                    .sheet(isPresented: $showDesignSheet) {
                        DesignSheetView()
                    }
                    
                    Button {
                        showAboutMeSheet.toggle()
                    } label: {
                        SettingRowView(imageString: "person.fill", linkTitle: "关于开发者")
                    }
                    .sheet(isPresented: $showAboutMeSheet) {
                        AboutMeSheetView()
                    }
                } header: {
                    Text("关于")
                }
                
                Section {
                    HStack {
                        Toggle(isOn: $isToggle) {
                            HStack {
                                Image(systemName: "key.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 18, height: 18)
                                    .opacity(0.3)
                                Text("开启面容ID验证")
                                    .fontWeight(.medium)
                            }
                        }
                        .tint(.blue)
                        .padding(.vertical, 8)
                    }
                } footer: {
                    Text("开启后，打开App时会进行验证")
                }

                
                Section {
                    Button {
                        showSafari.toggle()
                    } label: {
                        HStack {
                            Image("chatGPT")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 36, height: 36)
                                .cornerRadius(10)
                            Text("ChatGPT")
                                .fontWeight(.medium)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .opacity(0.3)
                        }
                        .padding(.vertical, 4)
                        .foregroundColor(.primary)
                    }
                    .safariView(isPresented: $showSafari) {
                        SafariView(url: URL(string: "https://apple.com.cn")!)
                    }

                } header: {
                    Text("致谢")
                }
                
                Section {
                    Button {
                        
                    } label: {
                        SettingRowView(imageString: "square.and.arrow.up.fill", linkTitle: "分享产品")
                    }

                    Button {
                        emailFeedBack()
                    } label: {
                        SettingRowView(imageString: "ellipsis.message.fill", linkTitle: "产品反馈")
                    }
                    
                    Button {
                        showPrivacy.toggle()
                        
                    } label: {
                        SettingRowView(imageString: "hand.raised.slash.fill", linkTitle: "隐私政策")
                    }
                    .sheet(isPresented: $showPrivacy) {
                        PrivacySheetView()
                    }

                    Button {
                        
                    } label: {
                        SettingRowView(imageString: "star.fill", linkTitle: "去评分")
                    }
                    
                } header: {
                    Text("其它")
                }
            }
            .navigationTitle("设置")
        }
    }
    
    //唤起邮件函数
    private func emailFeedBack() {
        //获取APP名称及版本、iOS版本
        if let appName = Bundle.main.infoDictionary?["CFBundleName"] as? String,
           let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            let iOSVersion = UIDevice.current.systemVersion
            
            let subject = "\(appName)-\(appVersion);iOS-\(iOSVersion)" //注意不要有空格，若有，addingPercentEncoding来处理
            
            //发送电子邮件的 URL 格式应该以 mailto: 开头，然后跟着收件人的电子邮件地址。使用 ?subject= 添加主题内容
            let email = "mailto:jia15176168273@icloud.com?subject=\(subject)"
            
            if let emailURL = URL(string: email) {
                UIApplication.shared.open(emailURL)
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(isToggle: .constant(true))
    }
}
