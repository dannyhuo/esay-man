package com.easy.man.schedule;

import com.easy.man.entity.bo.NodeMemoryBO;
import com.easy.man.entity.bo.ServiceGcDetailBO;
import com.easy.man.entity.po.ServiceGcDetail;
import com.easy.man.entity.po.Services;
import com.easy.man.entity.vo.ServiceVO;
import com.easy.man.service.INodeMemoryService;
import com.easy.man.service.IServiceGcDetailService;
import com.easy.man.service.IServicesService;
import com.easy.man.sh.ShellUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/***
 * 内存采集调度任务
 * @author danny
 *
 * @since 2018-01-11
 */
@Component(value = "serviceGcSchedule")
public class ServiceGcSchedule {

    private static int memSize = 3;

    private Logger logger = LoggerFactory.getLogger(this.getClass());


    private static String JSTAT = "jvm/jstat-gc.sh";
    private static String BLANK = " ";
    private String classPath = "";

    @Value("${easy.man.bin}")
    private static String bin = "/home/az-user/work/monitor/easy-man-0.0.1-SNAPSHOT/bin/";

    @Autowired
    private IServiceGcDetailService iServiceGcDetailService;

    @Autowired
    private IServicesService iServicesService;

    public ServiceGcSchedule () {
        super();
        classPath = this.getClass().getClassLoader().getResource("").getPath();
    }


    @Scheduled(cron = "0 */1 * * * *")
    public void serviceGcSampling () {
        logger.info("invoke serviceGcSampling ...");
        List<ServiceVO> services = iServicesService.listServiceByPage(1, 1000);
        int size;
        if (null == services || (size = services.size()) == 0) {
            logger.info("No service.......");
            return;
        }

        for (int i = 0; i < size; i++) {
            ServiceVO service = services.get(i);
            StringBuffer cmdBuffer = new StringBuffer();
            cmdBuffer.append("sh ");
            cmdBuffer.append(bin);
            cmdBuffer.append(JSTAT);
            cmdBuffer.append(BLANK);
            cmdBuffer.append(service.getNode().getHostName());
            cmdBuffer.append(BLANK);
            cmdBuffer.append(service.getNode().getUserName());
            cmdBuffer.append(BLANK);
            cmdBuffer.append(service.getServiceName());
            cmdBuffer.append(BLANK);
            List<String> rs = ShellUtil.exec(cmdBuffer.toString());
            logger.info(cmdBuffer.toString() + ", line count is " + rs.size());

            if (null != rs && rs.size() == 2) {
                String[] t1 = ShellUtil.pickArray(rs.get(0));
                String[] t2 = ShellUtil.pickArray(rs.get(1));

                Map<String, String> gcMap = new HashMap<>(20);
                for (int j = 0; j < t1.length; j++) {
                    gcMap.put(t1[j], t2[j]);
                }


                ServiceGcDetailBO gcDetailBO = new ServiceGcDetailBO();
                gcDetailBO.setServiceId(service.getServiceId());
                gcDetailBO.setServiceName(service.getServiceName());
                logger.info("init bo.....");
                gcDetailBO.initGc(gcMap);

                logger.info("gcDetailBo = " + gcDetailBO);

                boolean sucess = iServiceGcDetailService.save(gcDetailBO);

                logger.info("save status = " + sucess);
            } else {
                for (int j = 0; j < rs.size(); j++) {
                    logger.error(rs.get(j));
                }

            }

        }

    }



    public static void main(String[] args){

        StringBuffer cmdBuffer = new StringBuffer();
        cmdBuffer.append(JSTAT);
        cmdBuffer.append(BLANK);
        cmdBuffer.append("cdp");
        cmdBuffer.append(BLANK);
        cmdBuffer.append("az-user");
        cmdBuffer.append(BLANK);
        cmdBuffer.append("nodemanager");
        cmdBuffer.append(BLANK);
        List<String> rs = ShellUtil.exec(cmdBuffer.toString());
        if (null != rs && rs.size() == 2) {
            String[] t1 = ShellUtil.pickArray(rs.get(0));
            String[] t2 = ShellUtil.pickArray(rs.get(1));

            Map<String, String> gcMap = new HashMap<>(20);
            for (int j = 0; j < t1.length; j++) {
                gcMap.put(t1[j], t2[j]);
            }

            ServiceGcDetailBO gcDetailBO = new ServiceGcDetailBO();
            gcDetailBO.initGc(gcMap);


            System.out.println();
        }
    }

    private void samplingGc (Services service) {

    }

}
