package Test; /**
 * Created by 63263 on 2017/3/8.
 */

import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;
import java.util.concurrent.atomic.AtomicInteger;

@ServerEndpoint(value = "/chat")
public class Server {
    private static final String GUEST_PREFIX = "Guest";
    private static final AtomicInteger connectionIds = new AtomicInteger(0);
    private static final Set<Server> connections = new CopyOnWriteArraySet<Server>();
    private static List<String> names = new ArrayList<>();
    private Session session;
    private String username;

    public Server() {
//        nikename = GUEST_PREFIX + connectionIds.getAndIncrement();

    }

    @OnOpen
    public void start(Session session){
        try {
            username = URLDecoder.decode(session.getQueryString().substring(9), "UTF-8");
            names.add(username);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        System.out.println(username);
        System.out.println("Welcome!"+username);
        this.session = session;
        connections.add(this);
        String message = String.format("%s:%s",username,"has joined");
        broadcast(message);
        for(Server client : connections){
            try{
                synchronized(client){//线程池
                   for(Server c2 : connections){
                       System.out.println("zaixian");
                       String message2 = String.format("%s:%s","onLine!",c2.username);
                       client.session.getBasicRemote().sendText(message2);
                   }
                }
            } catch (IOException e) {
                connections.remove((client));
                try{
                    client.session.close();
                } catch (IOException e1) {
                    e1.printStackTrace();
                }
                String message2 = String.format("%s: %s",client.username,"has been disconnected");
                broadcast(message2);
                e.printStackTrace();
            }
        }
    }

    @OnClose
    public void end(){
        System.out.println("Good-bye");
        connections.remove(this);
        names.remove(username);
        String message = String.format("%s: %s",username,"has disconnected");
        broadcast(message);
        broadcast(names);
    }
    //
    @OnMessage
    public void submit(Session session,String message){
        System.out.println(session.getId()+": "+message);
        String target = message.split("00110011")[0];
        System.out.println(target);
        message = message.split("00110011")[1];
        System.out.println(message);
        String mm = String.format("%s: %s",username,message);//解析目标和内容


        //对制定目标发送信息
        if(target.toUpperCase().equals("ALL")){
            broadcast(mm);
        }else if(target.toUpperCase().startsWith("SERVICE")){
            username = target.substring(7);
            System.out.println("信息来自："+username);
            for(Server client : connections) {
                try {
                    synchronized (client) {
                        if (client.username.equals("Service")) {
                            System.out.println("find");
                            String message2 = String.format("%s: %s", username, message);
                            client.session.getBasicRemote().sendText(message2);
                            session.getBasicRemote().sendText(message2);
                        }
                    }
                } catch (Exception e) {
                    System.out.println("找不到指定客服");
                    e.getMessage();
                }
            }
        }else{
            for(Server client : connections){
                try{
                    synchronized(client){
                        if(client.username.equals(target)){
                            String message2 = String.format("%s: %s",username,message);
                            client.session.getBasicRemote().sendText(message2);
                            session.getBasicRemote().sendText(message2);
                        }
                    }
                } catch (IOException e) {
                    System.out.println("Chat Error to send message to client");
                    connections.remove((client));
                    try{
                        client.session.close();
                    } catch (IOException e1) {
                        e1.printStackTrace();
                    }
                    String message2 = String.format("%s: %s",client.username,"has been disconnected");
                    broadcast(message2);
                }
            }
        }
//            session.getBasicRemote().sendText("服务器：ni hao");

    }

    @OnError
    public void error(Throwable t)throws Throwable{
        System.out.println(t.toString());
    }

    private static void broadcast(String message) {
        for(Server client : connections){
            try{
                synchronized(client){//线程池
                    if(!client.username.equals("Service"))
                        client.session.getBasicRemote().sendText(message);
                }
            } catch (IOException e) {
                System.out.println("Chat Error to send message to client");
                connections.remove((client));
                try{
                    client.session.close();
                } catch (IOException e1) {
                    e1.printStackTrace();
                }
                String message2 = String.format("%s: %s",client.username,"has been disconnected");
                broadcast(message2);
                e.printStackTrace();
            }
        }
    }
    private static void broadcast(List names) {
        for(Server client : connections){
            try{
                synchronized(client){//线程池
                   for(int i = 0;i<names.size();i++){
                       String msg = names.get(i)+":";
                       client.session.getBasicRemote().sendText(msg);
                   }
                }
            } catch (IOException e) {
                connections.remove((client));
                try{
                    client.session.close();
                } catch (IOException e1) {
                    e1.printStackTrace();
                }
                e.printStackTrace();
            }
        }
    }

}
