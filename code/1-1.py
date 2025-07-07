import matplotlib.pyplot as plt
import numpy as np
import matplotlib as mpl
import matplotlib.font_manager as fm
font_prop = fm.FontProperties(family=['SimSun'])

# 实际数据
time_actual = [0, 2, 4, 6, 8, 10, 11.5]
battery_actual = [100, 85, 70, 50, 35, 15, 5]

# 模型预测
def battery_model(t):
    return 100 - 7.5 * t

# 生成预测数据
time_model = np.linspace(0, 12, 100)
battery_model_values = battery_model(time_model)

# 设置更美观的颜色方案
actual_color = '#E63946'  # 鲜红色
model_color = '#457B9D'   # 深蓝色
background_color = '#FFFFFF'  # 白色

# 设置绘图风格
plt.style.use('classic')  # 使用经典样式
plt.figure(figsize=(14, 8), facecolor=background_color)
ax = plt.gca()
ax.set_facecolor(background_color)

# 绘图
plt.plot(time_actual, battery_actual, 'o-', color=actual_color, label='实际数据', markersize=8, linewidth=2)
plt.plot(time_model, battery_model_values, '-', color=model_color, label='模型预测', linewidth=2.5)

# # 在每个实际数据点上标注数值
# for i, (x, y) in enumerate(zip(time_actual, battery_actual)):
#     plt.annotate(f'{y}%', 
#                 xy=(x, y), 
#                 xytext=(0, 10),
#                 textcoords='offset points',
#                 ha='center',
#                 fontsize=24,
#                 fontweight='bold',
#                 fontproperties=font_prop,
#                 bbox=dict(boxstyle='round,pad=0.3', fc='white', alpha=0.7))

# # 在模型预测曲线上标注几个关键点
# key_times = [0, 2, 4, 6, 8, 10, 11.5]
# for t in key_times:
#     if t <= max(time_model):
#         y_pred = battery_model(t)
#         plt.annotate(f'{y_pred}%', 
#                     xy=(t, y_pred), 
#                     xytext=(0, -15),
#                     textcoords='offset points',
#                     ha='center',
#                     fontsize=24,
#                     color=model_color,
#                     fontproperties=font_prop,
#                     bbox=dict(boxstyle='round,pad=0.2', fc='white', alpha=0.7))

# 设置标签和标题
plt.xlabel('使用时间 (小时)', fontsize=36, fontweight='bold', fontproperties=font_prop)
plt.ylabel('电池电量 (%)', fontsize=36, fontweight='bold', fontproperties=font_prop)

# 设置图例和网格
# plt.legend(fontsize=32, prop=font_prop)
plt.grid(True, alpha=0.3, linestyle='--')
plt.xlim(0, 12)
plt.ylim(0, 105)

# 放大坐标轴刻度字号
plt.xticks(fontsize=24)
plt.yticks(fontsize=24)

# 添加阴影区域表示低电量警告
plt.axhspan(0, 20, alpha=0.2, color='#FFCCCB', label='低电量区域')

plt.tight_layout()

# 保存为PDF文件
plt.savefig('images/1-1.pdf', format='pdf', dpi=600, bbox_inches='tight')
plt.show()

# 计算模型准确度
print("模型预测结果：")
for t in time_actual:
    predicted = battery_model(t)
    actual = battery_actual[time_actual.index(t)]
    error = abs(predicted - actual)
    print(f"时间 {t}h: 预测 {predicted}%, 实际 {actual}%, 误差 {error}%")