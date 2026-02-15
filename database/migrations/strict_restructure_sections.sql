-- Strict Section Restructuring (Chinese + Schema Fix)

-- 1. Add new column
ALTER TABLE sections ADD COLUMN IF NOT EXISTS chapter_detailed_description TEXT;

-- 2. Update Data (Sync from JSON)
UPDATE sections SET 
    chapter_detailed_description = '',
    description = '',
    estimated_minutes = 10,
    updated_at = NOW()
WHERE id = 'Both_Limits_unit_test' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Notation',
    estimated_minutes = 13,
    updated_at = NOW()
WHERE id = '2.2' AND topic_id = 'Both_Derivatives';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = '',
    estimated_minutes = 10,
    updated_at = NOW()
WHERE id = 'Both_Composite_unit_test' AND topic_id = 'Both_Composite';
UPDATE sections SET 
    chapter_detailed_description = '（线性近似的进阶版）继续深入探讨如何用直线模型来逼近非线性问题。重点在于理解“局部线性”是微分学的灵魂。题目往往结合图形，要求你直观地判断切线与曲线的位置关系，从而评估近似值的准确度。',
    description = 'Linearization',
    estimated_minutes = 19,
    updated_at = NOW()
WHERE id = '4.6' AND topic_id = 'Both_Applications';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = '',
    estimated_minutes = 10,
    updated_at = NOW()
WHERE id = 'Both_Applications_unit_test' AND topic_id = 'Both_Applications';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Integration by Parts',
    estimated_minutes = 15,
    updated_at = NOW()
WHERE id = '6.11' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    chapter_detailed_description = '平均值定理（MVT）保证了：在一段旅程中，如果你平均速度是60码，那么一定有某个瞬间你的仪表盘正好指在60码。这章不仅要求你会算这个“瞬间”c，更要理解它的几何意义（切线平行于割线）。验证前提条件（连续且可导）是解题的第一步，千万别漏。',
    description = 'MVT',
    estimated_minutes = 10,
    updated_at = NOW()
WHERE id = '5.1' AND topic_id = 'Both_Analytical';
UPDATE sections SET 
    chapter_detailed_description = '微分方程听起来高大上，其实就是“含导数的方程”。这章主要教怎么“建模”：把“人口增长率与人口成正比”这句话翻译成 dy/dt = ky。这是理解动态系统的第一步，重点是理解每个符号代表的物理意义。',
    description = 'Modeling',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '7.1' AND topic_id = 'Both_DiffEq';
UPDATE sections SET 
    chapter_detailed_description = '怎么判断一个函数是不是微分方程的解？很简单：求导，代进去，看等号两边是否相等。这章不需要你解方程，主要是让你熟悉微分方程的解是一个“函数”而非数值的概念，同时顺便复习一下求导。',
    description = 'Verifying',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '7.2' AND topic_id = 'Both_DiffEq';
UPDATE sections SET 
    chapter_detailed_description = '斜率场（Slope Fields）是微分方程的“可视化”。我们在坐标系里画满小短线，每一根短线的斜率都由微分方程决定。顺着这些短线的方向，你就能描绘出解曲线的形状。AP考试经常让你根据斜率场选方程。',
    description = 'Slope Fields',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '7.3' AND topic_id = 'Both_DiffEq';
UPDATE sections SET 
    chapter_detailed_description = '利用斜率场进行推理。通过观察斜率的分布规律（比如是不是只跟x有关？换个象限斜率正负如何？），我们可以反推微分方程的特征，甚至预测解的长期行为（比如会不会趋向于某条渐近线）。',
    description = 'Reasoning',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '7.4' AND topic_id = 'Both_DiffEq';
UPDATE sections SET 
    chapter_detailed_description = '（BC Only）欧拉方法：一种用计算机思维解方程的数值方法。既然我们无法总求出解析解，那就从起点出发，沿着切线方向“小步快跑”估算下一个点。列表计算要非常仔细，一步错步步错。',
    description = 'Euler Method',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '7.5' AND topic_id = 'Both_DiffEq';
UPDATE sections SET 
    chapter_detailed_description = '分离变量法：解微分方程的万能钥匙（对于一阶方程）。口诀是“分离、积分、求解”。把 y 赶到左边，x 赶到右边，两边同时积分。这过程特别考验代数基本功，尤其是处理对数和指数运算的时候。',
    description = 'Separation',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '7.6' AND topic_id = 'Both_DiffEq';
UPDATE sections SET 
    chapter_detailed_description = '寻找特解。通解里有个常数 C，特解就是利用给定的初始条件（比如 y(0)=3）把 C 算出来。在FRQ大题里，求特解通常是分值最高的一问，步骤如果不完整（比如没分离变量就积分）会被扣掉所有分，一定要规范书写。',
    description = 'Particular Sol',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '7.7' AND topic_id = 'Both_DiffEq';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Estimation',
    estimated_minutes = 13,
    updated_at = NOW()
WHERE id = '2.3' AND topic_id = 'Both_Derivatives';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Differentiability',
    estimated_minutes = 12,
    updated_at = NOW()
WHERE id = '2.4' AND topic_id = 'Both_Derivatives';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Power Rule',
    estimated_minutes = 12,
    updated_at = NOW()
WHERE id = '2.5' AND topic_id = 'Both_Derivatives';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Linearity',
    estimated_minutes = 12,
    updated_at = NOW()
WHERE id = '2.6' AND topic_id = 'Both_Derivatives';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Basic Transcendentals',
    estimated_minutes = 10,
    updated_at = NOW()
WHERE id = '2.7' AND topic_id = 'Both_Derivatives';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Product Rule',
    estimated_minutes = 14,
    updated_at = NOW()
WHERE id = '2.8' AND topic_id = 'Both_Derivatives';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Quotient Rule',
    estimated_minutes = 15,
    updated_at = NOW()
WHERE id = '2.9' AND topic_id = 'Both_Derivatives';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Numerical Limits',
    estimated_minutes = 17,
    updated_at = NOW()
WHERE id = '1.4' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Limit Laws',
    estimated_minutes = 18,
    updated_at = NOW()
WHERE id = '1.5' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Factoring/Conjugates',
    estimated_minutes = 21,
    updated_at = NOW()
WHERE id = '1.6' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Strategy',
    estimated_minutes = 18,
    updated_at = NOW()
WHERE id = '1.7' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Squeeze Theorem',
    estimated_minutes = 19,
    updated_at = NOW()
WHERE id = '1.8' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Chain Rule',
    estimated_minutes = 10,
    updated_at = NOW()
WHERE id = '3.1' AND topic_id = 'Both_Composite';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = '',
    estimated_minutes = 10,
    updated_at = NOW()
WHERE id = 'Both_Analytical_unit_test' AND topic_id = 'Both_Analytical';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Intervals',
    estimated_minutes = 21,
    updated_at = NOW()
WHERE id = '1.12' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Extensions',
    estimated_minutes = 24,
    updated_at = NOW()
WHERE id = '1.13' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Asymptotes',
    estimated_minutes = 24,
    updated_at = NOW()
WHERE id = '1.14' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'End Behavior',
    estimated_minutes = 23,
    updated_at = NOW()
WHERE id = '1.15' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'IVT',
    estimated_minutes = 24,
    updated_at = NOW()
WHERE id = '1.16' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Other Trig',
    estimated_minutes = 12,
    updated_at = NOW()
WHERE id = '2.10' AND topic_id = 'Both_Derivatives';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = '',
    estimated_minutes = 10,
    updated_at = NOW()
WHERE id = 'Both_Derivatives_unit_test' AND topic_id = 'Both_Derivatives';
UPDATE sections SET 
    chapter_detailed_description = '本章我们要探讨“导数在实际生活中的意义”。与其说是计算，不如说是翻译——把数学语言翻译成我们能听懂的增长率、冷却速度或加速度。你需要特别注意单位（比如“加仑/分钟”），并能准确区分“瞬时速率”和“平均速率”的差别。这是AP考试中非常强调的“数学沟通能力”。',
    description = 'Context',
    estimated_minutes = 12,
    updated_at = NOW()
WHERE id = '4.1' AND topic_id = 'Both_Applications';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Avg vs Instant Rate',
    estimated_minutes = 16,
    updated_at = NOW()
WHERE id = '1.1' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Limit Notation',
    estimated_minutes = 15,
    updated_at = NOW()
WHERE id = '1.2' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Graphical Limits',
    estimated_minutes = 16,
    updated_at = NOW()
WHERE id = '1.3' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Implicit',
    estimated_minutes = 13,
    updated_at = NOW()
WHERE id = '3.2' AND topic_id = 'Both_Composite';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Inverse Derivs',
    estimated_minutes = 14,
    updated_at = NOW()
WHERE id = '3.3' AND topic_id = 'Both_Composite';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Inverse Trig',
    estimated_minutes = 15,
    updated_at = NOW()
WHERE id = '3.4' AND topic_id = 'Both_Composite';
UPDATE sections SET 
    chapter_detailed_description = '求两条曲线围成的面积。基本思路是“上减下”积分。难点在于找交点（确定积分范围）和处理图形交叉（谁在上面变了）。画图！画图！画图！不画图很容易搞错上下关系。',
    description = 'Area dx',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '8.4' AND topic_id = 'Both_AppIntegration';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Strategy',
    estimated_minutes = 12,
    updated_at = NOW()
WHERE id = '3.5' AND topic_id = 'Both_Composite';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Higher Order',
    estimated_minutes = 11,
    updated_at = NOW()
WHERE id = '3.6' AND topic_id = 'Both_Composite';
UPDATE sections SET 
    chapter_detailed_description = '这是微积分最经典的物理应用：直线运动。我们会反复练习位置、速度（位置的导数）和加速度（速度的导数）三者之间的关系。重点在于判断物体什么时候静止？什么时候在往回走？什么时候在加速（注意：速度和加速度同号才是加速）？图解分析也是这章的重头戏。',
    description = 'Motion',
    estimated_minutes = 19,
    updated_at = NOW()
WHERE id = '4.2' AND topic_id = 'Both_Applications';
UPDATE sections SET 
    chapter_detailed_description = '除了物理运动，导数还可以描述任何“变化率”，比如面积扩大的速度、水流进出的速度，甚至是甚至经济学中的边际成本。解决这类应用题（Word Problems）的关键是：读懂题目，列出函数关系，然后求导。要特别留意符号的正负：水位下降，导数就是负的。',
    description = 'Other Rates',
    estimated_minutes = 18,
    updated_at = NOW()
WHERE id = '4.3' AND topic_id = 'Both_Applications';
UPDATE sections SET 
    chapter_detailed_description = '相关变化率（Related Rates）是很多同学的噩梦，但其实它有固定的套路。当几个变量都在随时间变化（比如梯子往下滑，x和y都在变），它们之间又满足某个几何关系（如勾股定理），我们就可以通过“对时间t求导”找到它们变化速度之间的联系。解题时要分清哪些量是常数，哪些是变量。',
    description = 'Intro RR',
    estimated_minutes = 18,
    updated_at = NOW()
WHERE id = '4.4' AND topic_id = 'Both_Applications';
UPDATE sections SET 
    chapter_detailed_description = '这章的核心思想是“以直代曲”。在局部范围内，曲线看起来就像直线（切线）。我们利用这个性质，用切线方程来估算复杂的函数值。这在没有计算器的时候非常有用。你还需要学会利用二阶导数（凹凸性）来判断你的估算值是偏大了还是偏小了。',
    description = 'Solving RR',
    estimated_minutes = 22,
    updated_at = NOW()
WHERE id = '4.5' AND topic_id = 'Both_Applications';
UPDATE sections SET 
    chapter_detailed_description = '洛必达法则（L''Hôpital''s Rule）是求不定式极限（0/0或∞/∞）的神器。通过求导，我们可以巧妙地化解这些看似无解的极限。但请记住：使用前必须先验证条件！只有确认是“不定式”才能用，否则会得出荒谬的结论。',
    description = 'L’Hospital',
    estimated_minutes = 20,
    updated_at = NOW()
WHERE id = '4.7' AND topic_id = 'Both_Applications';
UPDATE sections SET 
    chapter_detailed_description = '一阶导数就像函数的指南针，告诉我们函数是在上升还是下降。通过“一阶导数判别法”，我们可以找到函数的波峰（极大值）和波谷（极小值）。学会画“符号分析图”（Sign Chart）能帮你清晰地整理思路，写出严谨的证明。',
    description = 'Inc/Dec',
    estimated_minutes = 11,
    updated_at = NOW()
WHERE id = '5.3' AND topic_id = 'Both_Analytical';
UPDATE sections SET 
    chapter_detailed_description = '二阶导数反映了曲线的弯曲方向，也就是“凹凸性”。f'''' > 0 是凹向上（像个碗），f'''' < 0 是凹向下（像个伞）。拐点就是凹凸性发生改变的地方。利用二阶导数也能判断极值，这在某些情况下比一阶导数法更方便。',
    description = '1st Deriv Test',
    estimated_minutes = 11,
    updated_at = NOW()
WHERE id = '5.4' AND topic_id = 'Both_Analytical';
UPDATE sections SET 
    chapter_detailed_description = '这章是“数学侦探”游戏：给你一堆关于导数的线索（符号表、图像），让你还原出原函数长什么样。这需要综合运用之前学的所有知识：增减性、极值、凹凸性、拐点。这不仅考察计算，更考察逻辑推理能力。',
    description = 'Candidates Test',
    estimated_minutes = 12,
    updated_at = NOW()
WHERE id = '5.5' AND topic_id = 'Both_Analytical';
UPDATE sections SET 
    chapter_detailed_description = '极值定理（EVT）告诉我们：闭区间上的连续函数一定有最大值和最小值。找最值的方法很简单：比较“所有候选点”——也就是导数为零的点、导数不存在的点，以及最重要的两个端点。很多应用题最终都是归结为求某个函数在闭区间上的最值。',
    description = 'EVT',
    estimated_minutes = 18,
    updated_at = NOW()
WHERE id = '5.2' AND topic_id = 'Both_Analytical';
UPDATE sections SET 
    chapter_detailed_description = '优化问题是导数应用的最高峰：如何在给定的限制条件下，让成本最低、利润最高或面积最大？所有的题目都遵循同一流程：建立模型 -> 确定定义域 -> 求导找临界点 -> 验证最值。难点通常在于如何把实际问题转化成数学公式。',
    description = 'Concavity',
    estimated_minutes = 13,
    updated_at = NOW()
WHERE id = '5.6' AND topic_id = 'Both_Analytical';
UPDATE sections SET 
    chapter_detailed_description = '这是优化问题的复杂版，可能涉及更抽象的几何图形或带有参数的经济模型。解题的核心依然是清晰的建模和严谨的求导步骤。面对大段文字不要慌，圈出关键数据，一步步列出方程。',
    description = '2nd Deriv Test',
    estimated_minutes = 12,
    updated_at = NOW()
WHERE id = '5.7' AND topic_id = 'Both_Analytical';
UPDATE sections SET 
    chapter_detailed_description = '全单元复习与综合应用。这时候你应该能熟练地在解析式、图像、表格和文字之间随意切换。特别是看导数的图推导原函数的性质，或者看原函数的图推导导数的性质，这是AP考试中最喜欢考的题型。',
    description = 'Sketching',
    estimated_minutes = 17,
    updated_at = NOW()
WHERE id = '5.8' AND topic_id = 'Both_Analytical';
UPDATE sections SET 
    chapter_detailed_description = '积分代表“总变化量”。如果你积分速度，得到的就是位移；如果你积分“漏水速度”，得到的就是漏出的总水量。这章通过各种实际背景（粒子运动、温度变化等）来训练你解释积分结果实际意义的能力，这对FRQ简答题至关重要。',
    description = 'Accumulation Funcs',
    estimated_minutes = 14,
    updated_at = NOW()
WHERE id = '6.5' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    chapter_detailed_description = '换元积分法（u-substitution）是复合函数求导（链式法则）的逆过程。当你看到被积函数里“既有函数又有它的导数”时，就该用换元法了。这一步非常关键：在定积分换元时，千万别忘了把积分上下限也一起换成新的变量 u 的范围！',
    description = 'FTC 2',
    estimated_minutes = 12,
    updated_at = NOW()
WHERE id = '6.7' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    chapter_detailed_description = '（BC Only）部分分式分解。面对复杂的有理分式（多项式除以多项式），我们可以把它拆成几个简单的分式之和，然后分别积分成对数形式。核心在于代数运算：如何通过解方程组把拆分后的系数求出来。',
    description = 'Substitution',
    estimated_minutes = 17,
    updated_at = NOW()
WHERE id = '6.9' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Synthesis',
    estimated_minutes = 18,
    updated_at = NOW()
WHERE id = '1.9' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Removable/Jump/Infinite',
    estimated_minutes = 20,
    updated_at = NOW()
WHERE id = '1.10' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = '3-Part Definition',
    estimated_minutes = 22,
    updated_at = NOW()
WHERE id = '1.11' AND topic_id = 'Both_Limits';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Slopes',
    estimated_minutes = 11,
    updated_at = NOW()
WHERE id = '2.1' AND topic_id = 'Both_Derivatives';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Connecting Graphs',
    estimated_minutes = 18,
    updated_at = NOW()
WHERE id = '5.9' AND topic_id = 'Both_Analytical';
UPDATE sections SET 
    chapter_detailed_description = '（BC Only）分部积分法（Integration by Parts）是乘积求导法则的逆过程。专门对付 x*e^x 或 ln(x) 这种硬骨头。记住 LIDET 口诀来选择 u 和 dv，会让过程顺畅很多。书写要条理清晰，否则负号很容易搞错。',
    description = 'Indefinite',
    estimated_minutes = 12,
    updated_at = NOW()
WHERE id = '6.8' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    chapter_detailed_description = '（BC Only）广义积分（反常积分）。当积分区间是无穷大，或者函数在某点垂直渐近（爆掉了），我们该怎么算？方法是引入极限。你要学会判断积分是收敛（算得出数）还是发散（无穷大）。这为后面级数的判别法打下了基础。',
    description = 'Alg Manipulation',
    estimated_minutes = 18,
    updated_at = NOW()
WHERE id = '6.10' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    chapter_detailed_description = '指数增长与衰减模型（dy/dt = ky）。这是自然界最常见的模型，细菌繁殖、放射性衰变都遵循这个规律。你要熟悉它的解结构 y = Ce^(kt)，并能根据“半衰期”或“倍增时间”迅速求出常数 k。',
    description = 'Exponential',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '7.8' AND topic_id = 'Both_DiffEq';
UPDATE sections SET 
    chapter_detailed_description = '（BC Only）逻辑斯蒂模型（Logistic Growth）：描述资源有限环境下的增长。种群无法无限增长，会受到承载量 M 的限制。你不需要解这个方程，但要深刻理解 S 形曲线的特征：增长最快是在人口达到承载量一半的时候。定性分析比定量计算更重要。',
    description = 'Logistic Models',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '7.9' AND topic_id = 'Both_DiffEq';
UPDATE sections SET 
    chapter_detailed_description = '求函数的平均值。想象把函数曲线下的面积重新捏成一个矩形，这个矩形的高度就是平均值。公式很简单：积分值除以区间长度。但你要能解释它的物理意义，比如“10秒内的平均速度”或“平均温度”。',
    description = 'Avg Value',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '8.1' AND topic_id = 'Both_AppIntegration';
UPDATE sections SET 
    chapter_detailed_description = '位置、速度与位移的进阶关系。积分速度得到的是位移（位置变化），积分速度的绝对值（速率）得到的才是总路程。这俩很容易搞混，做题时要特别注意区分 Net Change 和 Total Distance。',
    description = 'Motion',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '8.2' AND topic_id = 'Both_AppIntegration';
UPDATE sections SET 
    chapter_detailed_description = '积分的应用不仅限于运动。任何“累积”问题都可以用积分解决：水箱里多了多少水？消耗了多少能量？公式是：现在的量 = 初始量 + 变化率的积分。这类应用题关键是读题，把文字转化成积分模型。',
    description = 'Accumulation',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '8.3' AND topic_id = 'Both_AppIntegration';
UPDATE sections SET 
    chapter_detailed_description = '有时候沿y轴积分（dy）比沿x轴（dx）更简单。这时候就变成了“右减左”。你需要适应扭过头来看坐标系，或者把函数写成 x = g(y) 的形式。这是对空间想象力的一次小测验。',
    description = 'Area dy',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '8.5' AND topic_id = 'Both_AppIntegration';
UPDATE sections SET 
    chapter_detailed_description = '已知横截面求体积。这不是旋转体，而是把立体切片，每一片都是正方形或半圆等规则图形。公式是∫A(x)dx。难点在于找出截面面积 A(x) 和底面函数的关系。',
    description = 'Intersections',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '8.6' AND topic_id = 'Both_AppIntegration';
UPDATE sections SET 
    chapter_detailed_description = '旋转体体积：圆盘法（Disk）。把图形绕轴旋转一圈，切片是圆。体积就是所有圆片面积的积分。关键是找准旋转半径 R(x)。如果不是绕坐标轴旋转，半径的式子要小心调整。',
    description = 'Cross Sec 1',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '8.7' AND topic_id = 'Both_AppIntegration';
UPDATE sections SET 
    chapter_detailed_description = '旋转体体积：垫圈法（Washer）。如果旋转体中间是空的，切片就是个圆环（垫圈）。体积是大圆减小圆。一定要分清哪个是外半径 R，哪个是内半径 r，而且都是相对于旋转轴的距离。',
    description = 'Cross Sec 2',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '8.8' AND topic_id = 'Both_AppIntegration';
UPDATE sections SET 
    chapter_detailed_description = '（BC Only）弧长公式。计算曲线有多长。公式源于勾股定理的微元累加。虽然公式只需套用，但积分往往很复杂，常需要计算器或代数技巧。理解公式的来源能帮你记得更牢。',
    description = 'Disc',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '8.9' AND topic_id = 'Both_AppIntegration';
UPDATE sections SET 
    chapter_detailed_description = '（BC Only）旋转体表面积。结合了弧长和周长公式。公式里的 r 取决于绕哪个轴旋转。这是空间几何感要求最高的章节之一，画图辅助分析是必不可少的。',
    description = 'Disc Shift',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '8.10' AND topic_id = 'Both_AppIntegration';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Washer',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '8.11' AND topic_id = 'Both_AppIntegration';
UPDATE sections SET 
    chapter_detailed_description = '向量值函数：用向量 r(t) = <x(t), y(t)> 描述位置。这把数学和物理紧密结合起来了。向量的加减、求导、积分都是分量独立进行的。理解位置、速度、加速度向量之间的微积分关系是本章核心。',
    description = 'Vector Derivs',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '9.4' AND topic_id = 'BC_Unit9';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Abs/Cond',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '10.9' AND topic_id = 'BC_Series';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'AST Error',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '10.10' AND topic_id = 'BC_Series';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Opt Intro',
    estimated_minutes = 18,
    updated_at = NOW()
WHERE id = '5.10' AND topic_id = 'Both_Analytical';
UPDATE sections SET 
    chapter_detailed_description = '从这章开始，我们进入积分的世界。积分的本质是“累积”。我们先从几何直观入手，用一堆小矩形（黎曼和）来逼近曲线下方的面积。你要明白左端点、右端点和中点黎曼和的区别，以及它们在函数递增或递减时是高估了还是低估了。',
    description = 'Accumulation',
    estimated_minutes = 11,
    updated_at = NOW()
WHERE id = '6.1' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    chapter_detailed_description = '正式引入“定积分”符号。定积分就是“有向面积”：x轴上方的面积是正的，下方是负的。我们通过几何公式（比如三角形、半圆面积）来计算一些简单函数的积分。理解定积分与面积的关系是后续所有应用的基础。',
    description = 'Riemann Sums',
    estimated_minutes = 15,
    updated_at = NOW()
WHERE id = '6.2' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    chapter_detailed_description = '微积分基本定理（FTC）第一部分揭示了微分和积分是互逆运算。这也是为什么我们能求“变限积分函数”的导数。这类题目常结合函数图像考察，让你分析由积分定义的函数的增减性和凹凸性。',
    description = 'Def Integral',
    estimated_minutes = 13,
    updated_at = NOW()
WHERE id = '6.3' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    chapter_detailed_description = 'FTC第二部分是计算的神器：它把求积分转化为了求“原函数”。你不再需要画图数格子，只要找到反导数，代入上下限相减即可。这是连接微分与积分的桥梁，由于其重要性，请务必熟练掌握多项式、三角函数等基本函数的积分公式。',
    description = 'FTC 1',
    estimated_minutes = 16,
    updated_at = NOW()
WHERE id = '6.4' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    chapter_detailed_description = '积分技巧入门。我们会巩固基本的反导数规则，比如幂法则的逆运算、线性性质等。虽然看起来简单，但熟练度决定了你做题的速度。你要培养对函数原函数的“直觉”，看到 2x 就能立刻想到 x²。',
    description = 'Properties',
    estimated_minutes = 11,
    updated_at = NOW()
WHERE id = '6.6' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Partial Fractions',
    estimated_minutes = 16,
    updated_at = NOW()
WHERE id = '6.12' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Improper Integrals',
    estimated_minutes = 16,
    updated_at = NOW()
WHERE id = '6.13' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Selecting Techniques',
    estimated_minutes = 15,
    updated_at = NOW()
WHERE id = '6.14' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = '',
    estimated_minutes = 10,
    updated_at = NOW()
WHERE id = 'Both_Integration_unit_test' AND topic_id = 'Both_Integration';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = '',
    estimated_minutes = 10,
    updated_at = NOW()
WHERE id = 'Both_DiffEq_unit_test' AND topic_id = 'Both_DiffEq';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Taylor Poly',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '10.11' AND topic_id = 'BC_Series';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Lagrange',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '10.12' AND topic_id = 'BC_Series';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Radius/Interval',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '10.13' AND topic_id = 'BC_Series';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Finding Series',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '10.14' AND topic_id = 'BC_Series';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Ops on Series',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '10.15' AND topic_id = 'BC_Series';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = '',
    estimated_minutes = 10,
    updated_at = NOW()
WHERE id = 'BC_Series_unit_test' AND topic_id = 'BC_Series';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Washer Shift',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '8.12' AND topic_id = 'Both_AppIntegration';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Arc Length',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '8.13' AND topic_id = 'Both_AppIntegration';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = '',
    estimated_minutes = 10,
    updated_at = NOW()
WHERE id = 'Both_AppIntegration_unit_test' AND topic_id = 'Both_AppIntegration';
UPDATE sections SET 
    chapter_detailed_description = '参数方程：引入第三个变量 t（时间）来同时控制 x 和 y。这是描述二维平面运动的最佳工具。你会学到如何对参数方程求导 dy/dx，这代表了轨迹的斜率，而 dx/dt 和 dy/dt 则代表了水平和垂直方向的速度。',
    description = 'Parametric Derivs',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '9.1' AND topic_id = 'BC_Unit9';
UPDATE sections SET 
    chapter_detailed_description = '参数方程的二阶导数。求 d²y/dx² 是个大坑，千万别直接用二阶导数除以二阶导数！正确做法是对一阶导数 dy/dx 再求导（关于 t），然后除以 dx/dt。这个考点几乎年年考，必须熟练掌握。',
    description = 'Parametric 2nd Deriv',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '9.2' AND topic_id = 'BC_Unit9';
UPDATE sections SET 
    chapter_detailed_description = '参数方程的积分。计算参数曲线围成的面积或弧长。重点是：当你把积分变量换成 t 时，积分的上下限也要对应变成 t 的范围。还要注意运动方向，积分方向搞反了结果会差一个负号。',
    description = 'Parametric Arc Length',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '9.3' AND topic_id = 'BC_Unit9';
UPDATE sections SET 
    chapter_detailed_description = '运动分析：速率（Speed）是速度向量的长度（模），路程是速率的积分。这些公式本质上和参数方程的一样，但用向量语言表述更简洁。要时刻区分“速度（向量）”和“速率（标量）”。',
    description = 'Vector Int',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '9.5' AND topic_id = 'BC_Unit9';
UPDATE sections SET 
    chapter_detailed_description = '极坐标：用距离 r 和角度 θ 来看世界。极坐标倒函数 dy/dx 的计算比较繁琐（乘积法则），建议多练几遍以保证计算准确率。理解 r 代表原点距离，θ 代表方向，能帮你快速画出简单极坐标图。',
    description = 'Vector Motion',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '9.6' AND topic_id = 'BC_Unit9';
UPDATE sections SET 
    chapter_detailed_description = '极坐标求面积。注意了，极坐标积分是用扇形微元（½r²dθ），而不是矩形条！所以公式前面有个1/2。找积分的上下限（角度范围）是最难的，通常需要结合对称性或解方程找交点。',
    description = 'Polar Derivs',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '9.7' AND topic_id = 'BC_Unit9';
UPDATE sections SET 
    chapter_detailed_description = '极坐标弧长。计算极曲线的长度。公式形式和参数方程类似。这类题目往往积分算不出来，只要求列式，或者用计算器求值。所以重点在于列式的正确性，特别是角度范围别搞错。',
    description = 'Polar Area',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '9.8' AND topic_id = 'BC_Unit9';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Area Between Polar',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '9.9' AND topic_id = 'BC_Unit9';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = '',
    estimated_minutes = 10,
    updated_at = NOW()
WHERE id = 'BC_Unit9_unit_test' AND topic_id = 'BC_Unit9';
UPDATE sections SET 
    chapter_detailed_description = '泰勒多项式：用多项式来模仿任意函数。这是级数的入门。核心思想是：如果在某一点，函数的值、一阶导、二阶导...都相等，那它们在这一点附近就长得很像。多项式次数越高，模仿得越像。',
    description = 'Convergence',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '10.1' AND topic_id = 'BC_Series';
UPDATE sections SET 
    chapter_detailed_description = '拉格朗日误差界：估算模仿得有多像。这是BC里的难点。本质上它是找“下一个导数的最大值”来限定误差范围。公式看起来吓人，但只要搞懂了原理，其实就是套公式而已。',
    description = 'Geometric',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '10.2' AND topic_id = 'BC_Series';
UPDATE sections SET 
    chapter_detailed_description = '泰勒级数：当多项式项数无限多时，它就变成了级数。你要熟背四个基本级数（e^x, sinx, cosx, 1/(1-x)）。利用它们通过代换、求导、积分来“组装”出新级数，比从头推导要快得多。',
    description = 'nth Term',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '10.3' AND topic_id = 'BC_Series';
UPDATE sections SET 
    chapter_detailed_description = '级数审敛法概览。这是本单元的重头戏。给你一个级数，判断它发散还是收敛？有点像看病诊断，你要学会根据级数的“长相”迅速选择合适的“化验单”（审敛法）。',
    description = 'Integral Test',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '10.4' AND topic_id = 'BC_Series';
UPDATE sections SET 
    chapter_detailed_description = '比较判别法。把它跟已知的级数（比如p级数）比大小。如果比收敛的大，那没用；如果比收敛的小，那也收敛。直觉判断（Limit Comparison）往往比直接比较更好用。',
    description = 'p-Series',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '10.5' AND topic_id = 'BC_Series';
UPDATE sections SET 
    chapter_detailed_description = '交错级数。正负号跳变的级数更容易收敛。交错级数判别法要求很简单：只要项的绝对值在减小且趋于0，它就收敛。它的误差估算也很简单：误差小于被舍弃的第一项。',
    description = 'Comparison',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '10.6' AND topic_id = 'BC_Series';
UPDATE sections SET 
    chapter_detailed_description = '比值判别法（Ratio Test）。这是求“收敛半径”的终极武器，特别是对于幂级数。计算后项与前项比值的极限。除了计算，别忘了最后单独测试区间的两个端点，这往往是得分点。',
    description = 'AST',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '10.7' AND topic_id = 'BC_Series';
UPDATE sections SET 
    chapter_detailed_description = '幂级数：定义域为收敛区间的函数。综合运用前面的知识，找出 x 在什么范围内级数是收敛的。从求收敛半径到测试端点，这一套流程必须行云流水般熟练。',
    description = 'Ratio Test',
    estimated_minutes = 8,
    updated_at = NOW()
WHERE id = '10.8' AND topic_id = 'BC_Series';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Solving Opt',
    estimated_minutes = 13,
    updated_at = NOW()
WHERE id = '5.11' AND topic_id = 'Both_Analytical';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Comprehensive assessment covering all topics in Unit 5.',
    estimated_minutes = 462,
    updated_at = NOW()
WHERE id = 'unit_test' AND topic_id = 'ABBC_Analytical';
UPDATE sections SET 
    chapter_detailed_description = '',
    description = 'Implicit Behaviors',
    estimated_minutes = 12,
    updated_at = NOW()
WHERE id = '5.12' AND topic_id = 'Both_Analytical';

-- 3. Cleanup Legacy Columns (SAFE TO RUN IF CONFIRMED)
-- ALTER TABLE sections DROP COLUMN IF EXISTS description2;
-- ALTER TABLE sections DROP COLUMN IF EXISTS description_2;
-- ALTER TABLE sections DROP COLUMN IF EXISTS detailed_description;
-- ALTER TABLE sections DROP COLUMN IF EXISTS topic_introduction;
