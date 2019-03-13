%rebase base position='CRON表达式说明', managetopli="help"
<div class="page-body">
    <div class="row">
        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
            <div class="widget">
                <div class="widget-header bordered-bottom bordered-themesecondary">
                    <i class="widget-icon fa fa-tags themesecondary"></i>
                    <span class="widget-caption themesecondary">帮助文档</span>
                    <div class="widget-buttons">
                        <a href="#" data-toggle="maximize">
                            <i class="fa fa-expand"></i>
                        </a>
                        <a href="#" data-toggle="collapse">
                            <i class="fa fa-minus"></i>
                        </a>
                        <a href="#" data-toggle="dispose">
                            <i class="fa fa-times"></i>
                        </a>
                    </div>
                </div><!--Widget Header-->
		<div style="padding:-10px 0px;" class="widget-body no-padding">
            <p>
            <br/>
            &nbsp;&nbsp;Cron表达式是一个字符串，字符串以空格隔开，分为5或6个域，每一个域代表一个含义，系统支持的表达式格式如下：<br /> 
            <pre>Seconds Minutes Hours DayofMonth Month [DayofWeek]</pre>
            &nbsp;&nbsp;其中 DayofWeek 为可选域。
            </p>
            <p>
            &nbsp;&nbsp;每一个域可出现的字符如下： 
            <ul>
                <li><b>Seconds:</b> 可出现"* / , -"四个字符，有效范围为0-59的整数</li>
                <li><b>Minutes:</b> 可出现"* / , -"四个字符，有效范围为0-59的整数 </li>
                <li><b>Hours:</b> 可出现"* / , -"四个字符，有效范围为0-23的整数 </li>
                <li><b>DayofMonth:</b> 可出现"* / , - ?"五个字符，有效范围为0-31的整数</li> 
                <li><b>Month:</b> 可出现", - * /"四个字符，有效范围为1-12的整数或JAN-DEC</li> 
                <li><b>DayofWeek:</b> 可出现"* / , - ?"五个字符，有效范围为0-6的整数或SUN-SAT两个范围。0表示星期天，1表示星期一， 依次类推 </li>
            </ul>
            </p>
            <p>
            &nbsp;&nbsp;各个字符的含义如下：
            <ul>
                <li>* 表示匹配该域的任意值，假如在Minutes域使用*, 即表示每分钟都会触发事件。</li>
                <li>? 字符仅被用于天（月）和天（星期）两个子表达式，表示不指定值，当2个子表达式其中之一被指定了值以后，为了避免冲突，需要将另一个子表达式的值设为“?”。</li>
                <li>- 表示范围，例如在Minutes域使用5-20，表示从5分到20分钟每分钟触发一次。</li>
                <li>/ 表示起始时间开始触发，然后每隔固定时间触发一次，例如在Minutes域使用5/20,则意味着5分钟触发一次，而25，45等分别触发一次。</li>
                <li>, 表示列出枚举值值。例如：在Minutes域使用5,20，则意味着在5和20分每分钟触发一次。</li>
            </ul>
            </p>
            <p>
            &nbsp;&nbsp;一些例子：
            <pre>
0 0 10,14,16 * * ? 每天上午10点，下午2点，4点触发 
0 0/30 9-17 * * ? 朝九晚五工作时间内每半小时触发  
0 0 12 ? * WED 表示每个星期三中午12点触发  
0 0 12 * * ? 每天中午12点触发 
0 15 10 ? * * 每天上午10:15触发 
0 15 10 * * ? 每天上午10:15触发 
0 15 10 * * ? * 每天上午10:15触发 
0 * 14 * * ? 在每天下午2点到下午2:59期间的每1分钟触发 
0 0/5 14 * * ? 在每天下午2点到下午2:55期间的每5分钟触发 
0 0/5 14,18 * * ? 在每天下午2点到2:55期间和下午6点到6:55期间的每5分钟触发 
0 0-5 14 * * ? 在每天下午2点到下午2:05期间的每1分钟触发 
0 10,44 14 ? 3 WED 每年三月的星期三的下午2:10和2:44触发 
0 15 10 ? * MON-FRI 周一至周五的上午10:15触发 
0 15 10 15 * ? 每月15日上午10:15触发 
0 15 10 L * ? 每月最后一日的上午10:15触发</pre>
            </p>
          
            </div> 
          </div> 
        </div>
    </div>
</div>
