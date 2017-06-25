# 第二章activity Toast
## 一、新建activity四个步骤：

1. 新建activity
2. 新建layout
3. 在activity中注册layout
```java
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.first_layout);
    }
```
4. 在AndriodManifest.xml中注册
```xml
        <activity android:name=".FirstActivity">
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
```
## 二、Toast的使用：
1. 注册按钮
```java
        Button btn1=(Button)findViewById(R.id.button1);
        btn1.setOnClickListener(new View.OnClickListener(){
                public void onClick(View v){
                }
         });
```
2. 使用Toast输出语句
```java
        Button btn1=(Button)findViewById(R.id.button1);
        btn1.setOnClickListener(new View.OnClickListener(){
                public void onClick(View v){
                    Toast.makeText(FirstActivity.this, "You Click Button1", Toast.LENGTH_SHORT).show();
                }
         });
```
3. 其中makTest(Context,文本内容,显示时长);
Context是☞活动对象，一般是指activity？
## 三、新建菜单：
1. 新建文件夹res/menu/main
2. 新建menu
在menu中右键新建Menu resource file
3. 在main.xml中新建item
```xml
<?xml version="1.0" encoding="utf-8"?>
<menu xmlns:android="http://schemas.android.com/apk/res/android">
    <item
        android:id="@+id/add_item"
        android:title="Add"/>
    <item
        android:id="@+id/remove_item"
        android:title="Romove"/>
</menu>
```
4. 重写activity中onCreateOptionsMenu方法
```java
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.main,menu);
        return true;
    }
```
5. 重写activity中onOptionsItemSelected方法
```java
    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()){
            case R.id.add_item:
                Toast.makeText(this,"点击第一个按钮",Toast.LENGTH_SHORT).show();
                break;
            case R.id.remove_item:
                Toast.makeText(this,"点击了第二个按钮",Toast.LENGTH_SHORT).show();
                break;
            default:
        }
        return true;
    }
```
## 四、销毁activity:
```java
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.first_layout);
        Button btn1=(Button)findViewById(R.id.button1);
        btn1.setOnClickListener(new View.OnClickListener(){
                public void onClick(View v){
                    finish();
                }
         });
    }
```
