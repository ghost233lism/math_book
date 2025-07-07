import matplotlib.pyplot as plt
import numpy as np
import matplotlib.font_manager as fm
font_prop = fm.FontProperties(family=['SimSun'])
time_actual = [0, 2, 4, 6, 8, 10, 11.5]# 实际数据
battery_actual = [100, 85, 70, 50, 35, 15, 5]
def battery_model(t):# 模型预测
    return 100 - 7.5 * t
time_model = np.linspace(0, 12, 100)# 生成预测数据
battery_model_values = battery_model(time_model)
actual_color = '#E63946'  # 鲜红色
model_color = '#457B9D'   # 深蓝色
background_color = '#FFFFFF'  # 白色
plt.style.use('classic')  
plt.figure(figsize=(14, 10), facecolor=background_color)
ax = plt.gca()
ax.set_facecolor(background_color)
plt.plot(time_actual, battery_actual, 'o-', color=actual_color, label='实际数据', markersize=8, linewidth=2)
plt.plot(time_model, battery_model_values, '-', color=model_color, label='模型预测', linewidth=2.5)
plt.xlabel('使用时间 (小时)', fontsize=24, fontweight='bold', fontproperties=font_prop)
plt.ylabel('电池电量 (%)', fontsize=24, fontweight='bold', fontproperties=font_prop)
plt.grid(True, alpha=0.3, linestyle='--')
plt.xlim(0, 12)
plt.ylim(0, 105)
plt.axhspan(0, 20, alpha=0.2, color='#FFCCCB', label='低电量区域')
plt.tight_layout()
plt.show()
