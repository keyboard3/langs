import java.text.SimpleDateFormat;
import java.util.*;

public class DateDemo {
  public static void main(String[] args) {
    testDate();
    testCalendar();
    testGcalendar();
  }

  public static void testDate() {
    // 获取当前日期
    Date date = new Date();
    System.out.println(date.toString());

    // 日期对比
    Date date1 = new Date(date.getTime() - 60 * 1000);
    System.out.println("时间戳对比:" + (date.getTime() > date1.getTime()));
    System.out
        .println("对比 before:" + date.before(date1) + " after:" + date.after(date1) + " equals:" + date.equals(date1));
    System.out.println("对比 compareTo: " + date.compareTo(date1));

    // 日期格式化
    Date dNow = new Date();
    SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
    System.out.println("当前时间为: " + ft.format(dNow));
    // 使用printf格式化日期
    // c的使用
    System.out.printf("全部日期和时间信息：%tc%n", date);
    // f的使用
    System.out.printf("年-月-日格式：%tF%n", date);
    // d的使用
    System.out.printf("月/日/年格式：%tD%n", date);
    // r的使用
    System.out.printf("HH:MM:SS PM格式（12时制）：%tr%n", date);
    // t的使用
    System.out.printf("HH:MM:SS格式（24时制）：%tT%n", date);
    // R的使用
    System.out.printf("HH:MM格式（24时制）：%tR", date);
    // 可以利用一个格式化字符串指出要被格式化的参数的索引，索引必须紧跟在%后面，而且必须以$结束
    System.out.printf("\n重复提供日期 %1$s %2$tB %2$td, %2$tY", "Due date:", date);
    // 可以使用 < 标志。它表明先前被格式化的参数要被再次使用
    System.out.printf("%s %tB %<te, %<tY", "Due date:", date);

    // b的使用，月份简称
    String str = String.format(Locale.US, "英文月份简称：%tb", date);
    System.out.println(str);
    System.out.printf("本地月份简称：%tb%n", date);
    // B的使用，月份全称
    str = String.format(Locale.US, "英文月份全称：%tB", date);
    System.out.println(str);
    System.out.printf("本地月份全称：%tB%n", date);
    // a的使用，星期简称
    str = String.format(Locale.US, "英文星期的简称：%ta", date);
    System.out.println(str);
    // A的使用，星期全称
    System.out.printf("本地星期的简称：%tA%n", date);
    // C的使用，年前两位
    System.out.printf("年的前两位数字（不足两位前面补0）：%tC%n", date);
    // y的使用，年后两位
    System.out.printf("年的后两位数字（不足两位前面补0）：%ty%n", date);
    // j的使用，一年的天数
    System.out.printf("一年中的天数（即年的第几天）：%tj%n", date);
    // m的使用，月份
    System.out.printf("两位数字的月份（不足两位前面补0）：%tm%n", date);
    // d的使用，日（二位，不够补零）
    System.out.printf("两位数字的日（不足两位前面补0）：%td%n", date);
    // e的使用，日（一位不补零）
    System.out.printf("月份的日（前面不补0）：%te", date);
  }

  public static void testCalendar() {
    // Calendar类实现了公历日历
    Calendar c1 = Calendar.getInstance();
    // 获得年份
    int year = c1.get(Calendar.YEAR);
    // 获得月份
    int month = c1.get(Calendar.MONTH) + 1;
    // 获得日期
    int date = c1.get(Calendar.DATE);
    // 获得小时
    int hour = c1.get(Calendar.HOUR_OF_DAY);
    // 获得分钟
    int minute = c1.get(Calendar.MINUTE);
    // 获得秒
    int second = c1.get(Calendar.SECOND);
    // 获得星期几（注意（这个与Date类是不同的）：1代表星期日、2代表星期1、3代表星期二，以此类推）
    int day = c1.get(Calendar.DAY_OF_WEEK);
    System.out.printf("\nCalendar: %d %d %d %d %d %d %d", year, month, date, hour, minute, second, day);
  }

  static void testGcalendar() {
    /*
     * GregorianCalendar是Calendar类的一个具体实现。 Calendar
     * 的getInstance（）方法返回一个默认用当前的语言环境和时区初始化的GregorianCalendar对象。
     * GregorianCalendar定义了两个字段：AD和BC。这是代表公历定义的两个时代。
     */
    String months[] = { "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" };

    int year;
    // 初始化 Gregorian 日历
    // 使用当前时间和日期
    // 默认为本地时间和时区
    GregorianCalendar gcalendar = new GregorianCalendar();
    // 显示当前时间和日期的信息
    System.out.print("Date: ");
    System.out.print(months[gcalendar.get(Calendar.MONTH)]);
    System.out.print(" " + gcalendar.get(Calendar.DATE) + " ");
    System.out.println(year = gcalendar.get(Calendar.YEAR));
    System.out.print("Time: ");
    System.out.print(gcalendar.get(Calendar.HOUR) + ":");
    System.out.print(gcalendar.get(Calendar.MINUTE) + ":");
    System.out.println(gcalendar.get(Calendar.SECOND));

    // 测试当前年份是否为闰年
    if (gcalendar.isLeapYear(year)) {
      System.out.println("当前年份是闰年");
    } else {
      System.out.println("当前年份不是闰年");
    }
  }
}