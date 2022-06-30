#### ConversationManager（会话管理）

| 方法                              | 描述                                   |
| --------------------------------- | -------------------------------------- |
| setConversationListener           | 会话监听                               |
| getAllConversationList            | 获取所有会话                           |
| getConversationListSplit          | 分页获取会话                           |
| getOneConversation                | 查询会话，如果会话不存在会自动生成一个 |
| getMultipleConversation           | 根据会话id获取多个会话                 |
| deleteConversation                | 通过会话id删除指定会话                 |
| setConversationDraft              | 设置会话草稿                           |
| pinConversation                   | 置顶会话                               |
| markGroupMessageHasRead           | 标记群聊会话已读                       |
| getTotalUnreadMsgCount            | 获取未读消息总数                       |
| getConversationIDBySessionType    | 查询会话id                             |
| setConversationRecvMessageOpt     | 消息免打扰设置                         |
| getConversationRecvMessageOpt     | 查询免打扰状态                         |
| setOneConversationPrivateChat     | 阅后即焚                               |
| deleteConversationFromLocalAndSvr | 删除本地以及服务器的会话               |
| deleteAllConversationFromLocal    | 删除所有本地会话                       |
| resetConversationGroupAtType      | 重置强提醒标识                         |
| getAtAllTag                       | 查询@所有人标识                        |



#### 泛型回调接口（所有方法都会回调此接口）

```
public interface OnBase<T> {
    /**
     * 失败
     * @param code 错误码
     * @param error 错误信息
     */
    void onError(int code, String error);

    /**
     * 成功
     * @param data 返回的实体
     */
    void onSuccess(T data);
}
```


#### getAllConversationList（获取所有会话）

```
    /**
     * 获取会话记录
     *
     * @param base callback List<{@link ConversationInfo}>
     */
    public void getAllConversationList(OnBase<List<ConversationInfo>> base)

```



#### getConversationListSplit（分页获取会话）

```
    /**
     * 获取会话记录
     *
     * @param base   callback List<{@link ConversationInfo}>
     * @param offset 偏移量，每次开始的index值
     * @param count  数量，每次获取的数量总数
     */
    public void getConversationListSplit(OnBase<List<ConversationInfo>> base, long offset, long count)
```



#### getOneConversation（获取一个会话，如果不存在会自动创建）

```
  /**
     * 获取单个会话
     *
     * @param sourceId:    单聊：UserId；群聊：GroupId
     * @param sessionType: 单聊：1；群聊：2
     * @param base         callback {@link ConversationInfo}
     */
    public void getOneConversation(OnBase<ConversationInfo> base, String sourceId, long sessionType)
```



#### getMultipleConversation（根据会话id查询会话）

```
    /**
     * 根据会话id获取多个会话
     *
     * @param conversationIDs 会话ID 集合
     * @param base            callback List<{@link ConversationInfo}>
     */
    public void getMultipleConversation(OnBase<List<ConversationInfo>> base, List<String> conversationIDs)
```



#### deleteConversation（根据会话id删除指定会话)

会触onTotalUnreadMessageCountChanged回调

```
  /**
     * 删除草稿
     *
     * @param conversationID 会话ID
     * @param base           callback String
     */

    public void deleteConversation(OnBase<String> base, String conversationID)
```



#### setConversationDraft（设置会话草稿）

会触onConversationChanged回调

```
    /**
     * 设置草稿
     *
     * @param conversationID 会话ID
     * @param draftText      草稿
     * @param base           callback String
     **/
    public void setConversationDraft(OnBase<String> base, String conversationID, String draftText) 
```



#### pinConversation（置顶会话）

会触onConversationChanged回调

```
    /**
     * 置顶会话
     *
     * @param conversationID 会话ID
     * @param isPinned       true 置顶； false 取消置顶
     * @param base           callback String
     **/
    public void pinConversation(OnBase<String> base, String conversationID, boolean isPinned) 
```



#### markGroupMessageHasRead（标记群会话已读，清除未读数）

会触onConversationChanged、onTotalUnreadMessageCountChanged回调

```
    /**
     * 标记群组会话已读
     *
     * @param groupID 群组ID
     * @param base    callback String
     */
    public void markGroupMessageHasRead(OnBase<String> base, String groupID)
```



#### getTotalUnreadMsgCount（获取未读消息总数）

```
    /**
     * 得到消息未读总数
     *
     * @param base String
     */
    public void getTotalUnreadMsgCount(OnBase<String> base) 
```



#### getConversationIDBySessionType（查询会话id）

```
  /**
     * 获取会话id；
     * 在从群列表进入聊天窗口后退群，这时候需要根据此方法获取会话id删除会话。
     *
     * @param sourceId:    聊值：UserId；聊值：GroupId
     * @param sessionType: 单聊：1；群聊：2
     */
    public String getConversationIDBySessionType(String sourceId, long sessionType)
```



#### setConversationRecvMessageOpt（设置免打扰模式）

```
    /**
     * 设置会话免打扰状态
     *
     * @param status 1:屏蔽消息; 2:接收消息但不提示; 0:正常
     */
    public void setConversationRecvMessageOpt(OnBase<String> base, List<String> conversationIDs, long status)
```



#### getConversationRecvMessageOpt（查询免打扰状态）

```
    /**
     * 获取会话免打扰状态
     * 1: Do not receive messages, 2: Do not notify when messages are received; 0: Normal
     * [{"conversationId":"single_13922222222","result":0}]
     */
    public void getConversationRecvMessageOpt(OnBase<List<NotDisturbInfo>> base, List<String> conversationIDs)
```



#### setOneConversationPrivateChat（开启阅后即焚）

```
    /***
     * 开启阅后即焚
     * @param conversionID 会话ID
     * @param isPrivate true开启
     * */
    public void setOneConversationPrivateChat(OnBase<String> base, String conversionID, boolean isPrivate) 
```



#### deleteConversationFromLocalAndSvr（删除本地跟服务器端会话记录）

```
    /***
     * 从本地和服务器删除会话跟历史消息
     * @param conversionID 会话ID
     * */
    public void deleteConversationFromLocalAndSvr(OnBase<String> base, String conversionID)
```



#### deleteAllConversationFromLocal（清空本地所有会话）

```
    /***
     * 从本地删除所有会话
     * */
    public void deleteAllConversationFromLocal(OnBase<String> base)
```



#### resetConversationGroupAtType（重置会话强提示标识位）

```
   /**
     * 清除@消息标志位
     *
     * @param conversationID 会话ID
     */
    public void resetConversationGroupAtType(OnBase<String> base, String conversationID)
```



#### getAtAllTag（@所有标识）

```
   /**
     * 查询at所有人标识
     */
    public String getAtAllTag()
```



#### simpleSort（自定义会话排序规则）

```
   /**
     * 会话排序比较器
     */
    public Comparator<ConversationInfo> simpleComparator()
```